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

  xit 'finds user by email -sad path' do 
    data = {data:nil}
    allow(UsersService).to receive(:find_user).and_return(data)
    results = UsersFacade.find_user({email: 'nonexisting@email.com' })

    expect(results).to eq('invalid email')
  end
end
