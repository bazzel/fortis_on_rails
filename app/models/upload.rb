class Upload < ActiveRecord::Base
  CSV_CONTENT_TYPES = [
    'text/csv'
    ]
  
  FILENAME_REGEX = /^(\d{9})eurmutaties((?:19|20)\d{2}(?:0[1-9]|1[012])(?:0[1-9]|[12][0-9]|3[01]))-((?:19|20)\d{2}(?:0[1-9]|1[012])(?:0[1-9]|[12][0-9]|3[01])).csv$/i

  # Paperclip
  has_attached_file :csv, {}.merge(APP_CONFIG['upload']['csv']['has_attached_file_options'].symbolize_keys)
  validates_attachment_presence :csv
  validates_attachment_content_type :csv, :content_type => CSV_CONTENT_TYPES

  validates_uniqueness_of :csv_file_name
  validates_format_of :csv_file_name, :with => FILENAME_REGEX, :allow_blank => true
  validate :consolidate_csv_validations
  
  before_create :extract_attributes_from_filename
  
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
    
    self.period_start = Date.parse(md[2])
    self.period_end = Date.parse(md[3])
  end
  
end
