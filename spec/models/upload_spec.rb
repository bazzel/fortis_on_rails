require 'spec_helper'

describe Upload do
  describe "validations" do
    it { Factory(:upload);should validate_uniqueness_of(:csv_file_name) }
    it "allow_values_for" do
      should allow_values_for(:csv_file_name, "861887719EURMutaties20100807-20100904.CSV",
                                              "861887719eurmutaties20100807-20100904.csv")
    end

    it "un-allow_values_for" do
      should_not allow_values_for(:csv_file_name, "invalid.csv",
                                                  "861887719EURMutaties20101301-20109999.CSV")
    end
    
    
  end
  
  describe "csv" do
    it { should have_attached_file(:csv) }
    # it { should validate_attachment_presence(:csv) }
    # it { should validate_attachment_content_type(:csv).
    #                   allowing(Upload::CSV_CONTENT_TYPES).
    #                   rejecting('text/plain', 'text/xml') }
    
    it "delegates validation errors on csv_file_name to csv attribute" do
      upload = Upload.new
      upload.valid?

      upload.should have(1).error_on(:csv_file_name)
      upload.should have(1).error_on(:csv_content_type)

      upload.should have(1).errors_on(:csv)
      
      upload.errors[:csv].should eql(upload.errors[:csv_file_name])
    end

    it "delegates validation errors on csv_content_type to csv attribute" do
      valid_file_name = '861887719EURMutaties20100807-20100904.CSV'
      upload = Upload.new

      upload.stub(:csv_file_name).and_return(valid_file_name)
      upload.valid?
    
      upload.should have(1).error_on(:csv_content_type)
    
      upload.should have(1).errors_on(:csv)

      upload.errors[:csv].should eql(upload.errors[:csv_content_type])
    end
    
  end
  
  describe "period_start and -_end" do
    before(:each) do
      @upload = Factory(:upload)
    end

    it "should set period_start filtered from filename" do
      @upload.period_start.should eql(Date.new(2010, 8, 7))
    end

    it "should set period_end filtered from filename" do
      @upload.period_end.should eql(Date.new(2010, 9, 4))
    end
    
  end
  
  
end
