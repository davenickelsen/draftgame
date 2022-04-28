require 'sinatra'
require 'sinatra/base'
require 'fig_newton'
require 'httpclient'
require_relative 'html_resolver'
require_relative 'time_checker'
require_relative 'user_resolver'
require_relative 'player_reader'
require_relative 'web_pick_reader'
require_relative 'web_pick_writer'

class App < Sinatra::Application
  set :app_file, __FILE__
  set :public_folder, File.dirname(__FILE__)

  def show_all_picks
    keys = UserResolver.all_keys
    model = WebPickReader.get_all_picks(keys)
    model.each do |item|
      item[:user] = UserResolver.get_user(item[:key])
    end
    HtmlResolver.view_all(model)
  end

  get '/' do
    content_type "text/html"
    if TimeChecker.has_draft_started? or !params[:peek].nil?
      return show_all_picks
    else
      return HtmlResolver.waiting_for_draft
    end
  end

  get '/:key' do
    key = params['key']
    name = UserResolver.get_user(key)
    if !name.nil?
      if TimeChecker.has_draft_started?
        return get_all_picks
      end
      content_type "text/html"
      players = PlayerReader.get_all_players
      user_picks = WebPickReader.get_picks(key)
      return HtmlResolver.open_list(name, key, user_picks, players)
    else
      status 404
    end

  end

  post '/:key' do
    key = params[:key]
    name = UserResolver.get_user(key)

    if !name.nil?
      data = request.body.read
      WebPickWriter.save_picks(key, data)
      "true"
    else
      status 500
    end

  end

end

year = Date.today.year
FigNewton.load("#{year}.yml")
App.run!