class UploadDetail < ActiveRecord::Base
  
  def cents
    bedrag.delete(",").to_i
  end
end
