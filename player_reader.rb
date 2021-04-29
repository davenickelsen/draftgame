require 'json'

class PlayerReader
  def self.get_all_players
    file = File.open(FigNewton.picks_file)
    data = file.read
    file.close
    JSON.parse(data)
  end
end