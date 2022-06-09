require 'rails_helper'

RSpec.describe MeetingsFacade do
  xit 'creates suggested meeting' do
    data = JSON.parse(File.read('spec/fixtures/suggested_meetings_data.json'), symbolize_names: true)
    

    meeeting = MeetingsFacade.suggested_meeting(data)

    expect(meeting).to be_a SuggestedMeeting
    expect(meeting.guest_email).to eq("user_search@email.com")
    expect(meeting.host_email).to eq("user@gmail.com")
    expect(meeting.locations).to be_all Locatioins
  end

  it 'creates a meeting', :vcr do 
    params = {:host_email=>"kimmieguo@gmail.com", :guest_email=>"xiaole.guo1@gmail.com", :location_name=>"Lucile's Creole Cafe", :location_address=>"2852 West Bowles Avenue, Littleton"}
    results = MeetingsFacade.create_meeting(params)


    expect(results[:status]).to eq('ok')
  end

  it 'gets existing meetings for a user' do 
    data = JSON.parse(File.read('spec/fixtures/meetings.json'), symbolize_names: true)
    allow(BackendService).to receive(:get_meetings).and_return(data)
    results = MeetingsFacade.get_meetings({email: 'user1@email.com'})

    expect(results).to be_all(Meeting)
    expect(results.first.host_name).to eq('user1')
    expect(results.last.guest_name).to eq('user1')
  end
end
