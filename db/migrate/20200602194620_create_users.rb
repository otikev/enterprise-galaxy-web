class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :auth_token
      t.string :activated
      t.string :activation_token
      t.date :activation_token_expiry
      t.boolean :enabled

      t.timestamps
    end
  end
end
