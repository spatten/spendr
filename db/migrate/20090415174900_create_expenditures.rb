class CreateExpenditures < ActiveRecord::Migration
  def self.up
    create_table :expenditures do |t|
      t.string :name
      t.text :description
      t.integer :amount
      t.date :purchase_date
      t.references :category
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :expenditures
  end
end