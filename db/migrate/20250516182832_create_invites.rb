class CreateInvites < ActiveRecord::Migration[8.0]
  def change
    create_table :invites do |t|
      t.bigint :attendee_id, index: true
      t.bigint :event_id, index: true

      t.integer :status, default: 0
      t.boolean :is_invited, default: false, null: false
      t.timestamps
    end
  end
end
