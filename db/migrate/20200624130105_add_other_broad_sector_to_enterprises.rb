class AddOtherBroadSectorToEnterprises < ActiveRecord::Migration[6.0]
  def change
    add_column :enterprises, :other_broad_sector, :string
  end
end
