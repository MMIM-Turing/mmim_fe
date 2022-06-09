class SuggestedMeeting
  attr_reader :host_email, :guest_email, :locations, :place_ids
  def initialize(hash)
    @host_email = hash[:host_email]
    @guest_email = hash[:guest_email]
    @place_ids = hash[:locations].map {|loc| loc.place_id}
    @locations = hash[:locations]
  end
end
