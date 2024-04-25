require 'nokogiri'
require 'json'

file = File.open('./fragment.html')
html_data = file.read
doc = Nokogiri::HTML(html_data)
file.close


nodes = doc.xpath("//div[contains(@class, 'player-details-container')]")
puts nodes[0].to_s
players = nodes.to_a.map{|p|
  anchors = p.css("a")
  name_node = anchors.at_xpath("div[contains(@class, 'player-name')]")
  name_text = name_node.nil? ? "Path not found" : name_node.text
  position_node = p.at_xpath("div[contains(@class, 'player-details')]")
  position_scan = position_node.text.scan(/(\w+)\s/)
  position_text = position_scan.nil? ? position_node.text : position_scan[0][0]
  college_node = position_node.at_xpath("a")
  college_text = college_node.text

  {"Name": name_text, "School": college_text, "Position": position_text }
}
puts players.to_json