require 'rails_helper'

RSpec.describe ScenicSpot, type: :model do
  describe "Association" do
    it {is_expected.to have_many(:scenic_spot_photos)}
  end
end
