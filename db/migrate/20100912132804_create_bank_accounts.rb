class CreateBankAccounts < ActiveRecord::Migration
  def self.up
    create_table :bank_accounts do |t|
      t.string :account_number, :limit => 10
      t.string :description, :limit => 100

      t.timestamps
    end
  end

  def self.down
    drop_table :bank_accounts
  end
end
