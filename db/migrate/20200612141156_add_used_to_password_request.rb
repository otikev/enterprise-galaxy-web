class AddUsedToPasswordRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :password_requests, :used, :boolean, { default: false }
  end
end
