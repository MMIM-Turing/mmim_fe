class SuggestedMeeting
  attr_reader :host_email, :guest_email, :locations

  def initialize(hash)
    @host_email = hash[:host_email]
    @guest_email = hash[:guest_email]
    @locations = hash[:locations]
  end
end
