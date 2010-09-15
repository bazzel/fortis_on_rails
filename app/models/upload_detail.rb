class UploadDetail < ActiveRecord::Base
  
  def cents
    # bedrag.gsub(',', '').to_i
    bedrag.delete(",").to_i
  end
end
