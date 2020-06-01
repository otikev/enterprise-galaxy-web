class RemoveStringFromAdvisers < ActiveRecord::Migration[6.0]
  def change
    remove_column :advisers, :string, :string
  end
end
