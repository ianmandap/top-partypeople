class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events, id: :uuid do |t|
      t.references :creator, type: :uuid, index: true, foreign_key: { to_table: :users }

      t.string :title
      t.string :display_poster
      t.datetime :start_date
      t.datetime :end_date
      t.string :location
      t.integer :max_capacity
      t.string :dress_code
      t.string :food_situation
      t.string :parking_instructions
      t.string :accommodation
      t.string :additional_info
      t.text :description
      t.boolean :is_public, default: true, null: false

      t.timestamps
    end
  end
end
