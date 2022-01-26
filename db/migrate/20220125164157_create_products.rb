class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.integer :amount_available, default: 0
      t.integer :cost
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
