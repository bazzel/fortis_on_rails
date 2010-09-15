class CreateUploadDetails < ActiveRecord::Migration
  def self.up
    create_table :upload_details do |t|

      [:rekeningnummer, :ten_laste_van, :boekdatum, :valutadatum, :bedrag, :munt_vd_rekening, :begunstigde, :begunstigde_rekening, :mutatie_omschrijving, :regel_1, :regel_2, :regel_3, :regel_4, :regel_5].each do |attribute|
        t.string attribute, :limit => 50
      end
      t.references :upload
      
      t.timestamps
    end
    
    add_index :upload_details, :upload_id
  end

  def self.down
    remove_index :upload_details, :upload_id
    drop_table :upload_details
  end
end
