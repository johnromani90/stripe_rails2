class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :stripe_key
      t.decimal :price
      t.integer :interval
      t.text :description

      t.timestamps
    end
  end
end
