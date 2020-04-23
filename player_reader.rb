require 'json'

class PlayerReader
  def self.get_all_players
    file = File.open('2020.json')
    data = file.read
    file.close
    JSON.parse(data)
  end
end