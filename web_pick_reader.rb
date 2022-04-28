class WebPickReader
  def self.get_picks(key)
    name = UserResolver.get_user(key)
    year = FigNewton.year
    note_key = "draft-#{name}-#{year}"
    token = ENV["FRIDGE_API_TOKEN"]
    host = ENV["FRIDGE_HOST"] || "http://localhost:64203"
    url = URI("#{host}/api/Notes?token=#{token}&key=#{note_key}")
    client = HTTPClient.new
    client.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE
    data = client.get_content(url)
    return [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil] if data.nil? or data == ""
    JSON.parse(data)
  end

  def self.get_all_picks(keys)
    keys.map{|k| {:key => k, :picks => self.get_picks(k)}}
  end
end