class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.integer :creator_id
      t.datetime :date
      t.string :location
      t.text :description
      t.boolean :is_public, default: true

      t.timestamps
    end
  end
end
