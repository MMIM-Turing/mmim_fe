class MeetingsFacade

  def self.suggested_meeting(hash)
    SuggestedMeeting.new(hash)
  end
end
