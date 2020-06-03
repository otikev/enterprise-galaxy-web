class AddRelationsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :enterprises, :user_id, :integer
    add_column :advisers, :user_id, :integer
  end
end
