class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.bigint :creator_id
      t.string :title
      t.datetime :date
      t.string :location
      t.text :description
      t.boolean :is_public, default: true, null: false

      t.timestamps
    end
  end
end
