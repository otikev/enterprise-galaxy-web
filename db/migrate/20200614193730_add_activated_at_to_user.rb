class AddActivatedAtToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :activated_at, :datetime
  end
end
