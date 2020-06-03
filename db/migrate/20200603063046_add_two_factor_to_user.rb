class AddTwoFactorToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :two_factor, :boolean, {default: false}
  end
end
