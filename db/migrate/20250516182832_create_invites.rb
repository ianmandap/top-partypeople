class CreateInvites < ActiveRecord::Migration[8.0]
  def change
    create_table :invites do |t|
      t.references :attendee, type: :uuid, index: true, foreign_key: { to_table: :users }
      t.references :event, type: :uuid, null: false, foreign_key: true, index: true

      t.integer :status, default: 0
      t.boolean :is_approved, default: false, null: false
      t.timestamps
    end
  end
end
