class PickWriter

  def self.save_picks(key, data)
    file_path = "picks/#{key}.json"
    file = File.open(file_path, "w")
    file.puts(data)
    file.close
  end
end