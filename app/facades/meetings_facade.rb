class MeetingsFacade

  def self.suggested_meeting(hash)
    SuggestedMeeting.new(hash)
  end

  def self.create_meeting(params)
    BackendService.create_meetings(params)
  end

  def self.get_meetings(params)

    data = BackendService.get_meetings(params)[:data]
    data.map {|data| Meeting.new(data)}
  end

end
