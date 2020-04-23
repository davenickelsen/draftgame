require 'erb'

class HtmlResolver

  def self.open_list(user, key, user_picks, players)
    model = {
        :players => players,
        :picks => user_picks,
        :user => user,
        :key => key,
        :options_binding => "optionsCaption: caption, options: players, optionsText: 'Description', value: pick%i"
    }
    self.resolve('html/open_list.erb', model)
  end

  def self.view_all(model)
    self.resolve('html/all_picks.erb', model)
  end

  def self.waiting_for_draft()
    resolve('html/waiting_for_draft.erb', {})
  end

  def self.resolve(file_path, model)
      file = File.open(file_path)
      template = file.read
      file.close
      processor = ERB.new(template, 0, "%<>")
      processor.result(binding)
  end

end