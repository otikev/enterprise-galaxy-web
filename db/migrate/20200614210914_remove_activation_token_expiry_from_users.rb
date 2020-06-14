class RemoveActivationTokenExpiryFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :activation_token_expiry
  end
end
