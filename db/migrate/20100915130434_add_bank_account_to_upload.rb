class AddBankAccountToUpload < ActiveRecord::Migration
  def self.up
    add_column :uploads, :bank_account_id, :integer
    add_index :uploads, :bank_account_id
  end

  def self.down
    remove_index :uploads, :bank_account_id
    remove_column :uploads, :bank_account_id
  end
end
