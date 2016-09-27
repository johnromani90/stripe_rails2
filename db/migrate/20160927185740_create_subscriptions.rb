class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :stripe_key, null: false
      t.integer :status_id, null: false

      t.timestamps
    end
  end
end
