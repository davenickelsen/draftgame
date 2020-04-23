class PickReader
  def self.get_picks(key)
    file_name = "picks/#{key}.json"
    return [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil] if !File.exists?(file_name)
    file = File.open(file_name)
    data = file.read
    file.close
    JSON.parse(data)
  end

  def self.get_all_picks(keys)
    keys.map{|k| {:key => k, :picks => self.get_picks(k)}}
  end
end