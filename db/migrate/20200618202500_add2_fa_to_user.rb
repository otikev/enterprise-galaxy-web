class Add2FaToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :google_secret, :string
    add_column :users, :mfa_secret, :string
  end
end
