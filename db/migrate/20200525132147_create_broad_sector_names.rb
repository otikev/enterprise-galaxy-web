class CreateBroadSectorNames < ActiveRecord::Migration[6.0]
  def change
    create_table :broad_sector_names do |t|
      t.string :name
      t.timestamps
    end
  end
end
