require 'date'

class TimeChecker
  def self.has_draft_started?
    today = DateTime.now
    draft_day = DateTime.parse(FigNewton.draft_time)
    today >= draft_day
  end
end