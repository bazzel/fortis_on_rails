class Upload < ActiveRecord::Base
  # === Constants
  CSV_CONTENT_TYPES = [
    'text/csv'
    ]
  
  FILENAME_REGEX = /^(\d{9})eurmutaties((?:19|20)\d{2}(?:0[1-9]|1[012])(?:0[1-9]|[12][0-9]|3[01]))-((?:19|20)\d{2}(?:0[1-9]|1[012])(?:0[1-9]|[12][0-9]|3[01])).csv$/i

  # Paperclip
  has_attached_file :csv, {}.merge(APP_CONFIG['upload']['csv']['has_attached_file_options'].symbolize_keys)

  # === Scopes

  # === Associations
  belongs_to :bank_account
  has_many :upload_details, :dependent => :destroy do
    def total_cents
      proxy_owner.upload_details.inject(0) {|total, detail| total + detail.cents } 
    end
  end

  # === Validations
  validates_attachment_presence :csv
  validates_attachment_content_type :csv, :content_type => CSV_CONTENT_TYPES

  validates_uniqueness_of :csv_file_name
  validates_format_of :csv_file_name, :with => FILENAME_REGEX, :allow_blank => true
  validate :consolidate_csv_validations
  
  # === Callbacks
  before_create :extract_attributes_from_filename
  # Paperclip saves the file in the after_save callback,
  # therefore we cannot process the file earlier (otherwise implement a custom Paperclip processor...)
  after_save :create_upload_details
  
  # === Instance Methods
  def predecessor
    self.class.predecessor(self)
  end
  
  def balance_start
    predecessor.try(:balance_end) || 0
  end
  
  def balance_end
    balance_start + upload_details.total_cents
  end
  
  # === Class Methods
  class << self
    # Find and return previous Upload for same BankAccount with an period_end
    # the day before ++upload++'s period_start date.
    def predecessor(upload)
      where({ :period_end => upload.period_start - 1, :bank_account_id => upload.bank_account }).first
    end
  end

  private
  # Put the first of the validation errors on csv (csv_file_name, csv_content_type)
  # so they will be displayed with the csv form element in the view.
  def consolidate_csv_validations
    attributes = [:csv_file_name, :csv_content_type]
    
    attributes.detect do |name|
      err = errors[name].to_s
      errors.add(:csv, err) unless err.blank?
    end
    
  end
  
  def extract_attributes_from_filename
    md = FILENAME_REGEX.match(csv_file_name)
    
    self.bank_account = BankAccount.find_by_account_number(md[1]) || BankAccount.create(:account_number => md[1])
    self.period_start = Date.parse(md[2])
    self.period_end = Date.parse(md[3])
  end

  def create_upload_details
    options = {
      :col_sep           => ';', 
      :headers           => true, 
      :skip_blanks       => true, 
      :header_converters => :symbol
    }

    FasterCSV.foreach(csv.path, options) do |row|
      upload_details.create row.to_hash
    end
    
  end
  
end
