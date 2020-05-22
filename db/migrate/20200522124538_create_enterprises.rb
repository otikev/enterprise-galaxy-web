class CreateEnterprises < ActiveRecord::Migration[6.0]
  def change
    create_table :enterprises do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
