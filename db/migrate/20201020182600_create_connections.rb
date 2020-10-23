class CreateConnections < ActiveRecord::Migration[6.0]
  def change
    create_table :connections do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.boolean :accepted

      t.timestamps
    end
  end
end
