require 'spec_helper'

describe UploadDetail do
  describe "cents" do
    it "should return bedrag multiplied by 100" do
      detail = Factory.build(:upload_detail, :bedrag => '+29,60')
      detail.cents.should eql(2960)
    end
    
    it "should handle negative bedragen properly" do
      detail = Factory.build(:upload_detail, :bedrag => '-29,60')
      detail.cents.should eql(-2960)
    end
  end
end
