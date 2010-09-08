class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      t.date :period_start
      t.date :period_end
      t.integer :balance_start
      t.integer :balance_end

      t.timestamps
    end
  end

  def self.down
    drop_table :uploads
  end
end
