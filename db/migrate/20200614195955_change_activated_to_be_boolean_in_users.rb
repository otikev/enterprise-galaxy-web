class ChangeActivatedToBeBooleanInUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :activated
    add_column :users, :activated, :boolean, {default: false}
  end
end
