require 'rails_helper'

RSpec.describe 'backend service' do
  describe 'class methods' do


    it '#get_url happy_path', :vcr do
      url = PhotoService.get_url('CnRvAAAAwMpdHeWlXl-lH0vp7lez4znKPIWSWvgvZFISdKx45AwJVP1Qp37YOrH7sqHMJ8C-vBDC546decipPHchJhHZL94RcTUfPa1jWzo-rSHaTlbNtjh-N68RkcToUCuY9v2HNpo5mziqkir37WU8FJEqVBIQ4k938TI3e7bf8xq-uwDZcxoUbO_ZJzPxremiQurAYzCTwRhE_V0')

      expect(url).to eq('https://lh3.googleusercontent.com/-qXSKhZUMPUs/T_AwIsUMSQI/AAAAAAAAB6o/AFnN5wOBZCg/s1600-w200/googlePhotowalk7.jpg')
    end

    it '#get_url sad_path', :vcr do 
      url = PhotoService.get_url('invalid_photo_ref')
      expect(url).to eq(nil)
    end
  end
end
