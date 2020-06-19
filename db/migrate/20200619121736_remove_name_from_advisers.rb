class RemoveNameFromAdvisers < ActiveRecord::Migration[6.0]
  def change
    remove_column :advisers, :name, :string
  end
end
