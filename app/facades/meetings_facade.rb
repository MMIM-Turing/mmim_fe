class MeetingsFacade

  def self.suggested_meeting(params)
    data = BackendService.suggest_meeting(params)[:data]
    binding.pry
  end

  def self.pending_meetings(email)
  end

end
