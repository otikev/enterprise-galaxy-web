class CreatePasswordRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :password_requests do |t|
      t.string :token
      t.datetime :expiry
      t.integer :user_id

      t.timestamps
    end
  end
end
