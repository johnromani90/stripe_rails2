class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.string :stripe_key, null: false
      t.decimal :price, null: false
      t.integer :interval_id, null: false
      t.text :description

      t.timestamps
    end
    add_index :plans, :name, unique: true
  end
end
