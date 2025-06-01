class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.bigint :creator_id, index: true

      t.string :title
      t.string :cover_image
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
