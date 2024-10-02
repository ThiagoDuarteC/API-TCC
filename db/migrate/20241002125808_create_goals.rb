class CreateGoals < ActiveRecord::Migration[7.2]
  def change
    create_table :goals do |t|
      t.string :name
      t.text :description
      t.string :background_color, :default =>  '#d4d2d2'
      t.string :icon_name
      t.datetime :deadline
      t.references :user, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
