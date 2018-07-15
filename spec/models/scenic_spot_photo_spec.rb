require 'rails_helper'

RSpec.describe ScenicSpotPhoto, type: :model do
  describe "Association" do
    it {is_expected.to belong_to(:scenic_spot)}
  end
end
