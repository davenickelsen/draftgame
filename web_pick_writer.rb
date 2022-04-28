class WebPickWriter

  def self.save_picks(key, data)
    name = UserResolver.get_user(key)
    year = FigNewton.year
    note_key = "draft-#{name}-#{year}"
    token = ENV["FRIDGE_API_TOKEN"]
    host = ENV["FRIDGE_HOST"] || "http://localhost:64203"
    url = URI("#{host}/api/Notes?token=#{token}&key=#{note_key}")
    client = HTTPClient.new
    client.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE
    client.post_content(url, data, {"Content-Type" => "application/json"})
  end
end