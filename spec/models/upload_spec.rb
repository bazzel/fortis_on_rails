require 'spec_helper'

describe Upload do
  describe "associations" do
    it { should belong_to(:bank_account) }
    it { should have_many(:upload_details, :dependent => :destroy) }
  end
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
  
  describe "bankaccount" do
    it "should create a new bankaccount if account number is not recognized" do
      lambda {
        Factory(:upload)
      }.should change(BankAccount, :count).by(1)
    end
    
    it "should not create a new bankaccount if accountnumber is recognized" do
      Factory(:bank_account, :account_number => '861887719')
      lambda {
        Factory(:upload)
      }.should_not change(BankAccount, :count)
    end
    
    it "should assign bankaccount to upload object" do
      bank_account = Factory(:bank_account, :account_number => '861887719')
      upload = Factory(:upload)

      upload.bank_account.should eql(bank_account)
    end
    
  end
  
  describe "predecessor" do
    before(:each) do
      @previous = Factory(:upload, :csv => File.open(Rails.root + 'tmp/861887719EURMutaties20100101-20100131.CSV', 'w+'))
      @current = Factory(:upload, :csv => File.open(Rails.root + 'tmp/861887719EURMutaties20100201-20100128.CSV', 'w+'))
    end

    it "should return previous Upload for same bankaccount" do
      Upload.predecessor(@current).should eql(@previous)
    end
    
    it "should have a precedessor attribute as well :)" do
      @current.predecessor.should eql(@previous)
    end
  end
  
  describe "total amount" do
    it "should return total amount of transactions" do
      Factory(:upload).upload_details.total_cents.should eql(-41993)
    end
  end
  
  describe "upload_details" do
    it "should create an upload_detail for every row in the uploaded file" do
      upload = Factory.build(:upload)
      lambda {
        upload.save
      }.should change(upload.upload_details, :size).by(3)
    end
  end
  
  describe "balance_start" do
    it "should be equal to 0 when uploading the first file" do
      Factory(:upload).balance_start.should eql(0)
    end

    it "should be equal to balance_end of predecessor" do
      upload = Factory.build(:upload)
      upload.stub(:predecessor).and_return(mock('Predecessor', :balance_end => 25000))
      upload.save
      upload.balance_start.should eql(25000)
    end
  end
  
  describe "balance_end" do
    it "should be equal to the total amount of the uploaded file when uploading the first file" do
      Factory(:upload).balance_end.should eql(-41993)
    end

    it "should be equal to balance_start plus the total amount of the uploaded file" do
      upload = Factory.build(:upload)
      upload.stub(:predecessor).and_return(mock('Predecessor', :balance_end => 25000))
      upload.save
      upload.balance_end.should eql(-16993)
    end
  end
end
