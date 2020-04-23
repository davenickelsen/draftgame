require 'date'

class TimeChecker
  def self.has_draft_started?
    today = DateTime.now
    draft_day = DateTime.parse('23-APR-2020 8:00:00 PM EST')
    today >= draft_day
  end
end