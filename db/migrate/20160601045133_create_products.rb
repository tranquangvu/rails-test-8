class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.integer :manufacturer_id
      t.integer :type_id

      t.timestamps null: false
    end
    add_index :products, :manufacturer_id
    add_index :products, :type_id
  end
end
