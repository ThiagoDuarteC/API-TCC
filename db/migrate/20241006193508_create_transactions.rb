class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.text :description
      t.decimal :value, precision: 10, scale: 2
      t.integer :transaction_type, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :category, null: false, foreign_key: true, index: true
      t.references :account, null: false, foreign_key: true, index: true
      t.references :goal, foreign_key: true, index: true
      t.datetime :deleted_at
      t.date :transaction_date
      t.timestamps
    end
  end
end
