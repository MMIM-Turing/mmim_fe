class SuggestedMeeting
  attr_reader :host_email, :guest_email, :locations, :expires_at

  def initialize(hash)
    @host_email = hash[:host_email]
    @guest_email = hash[:guest_email]
    @locations = hash[:locations]
    @expires_at = (Time.now + 1.day).to_s
  end

  def meeting_ddl
    Time.parse(@expires_at).strftime('%b %-d, %Y') +' ' + Time.parse(expires_at).strftime('%l:%M %p').lstrip
  end
end
