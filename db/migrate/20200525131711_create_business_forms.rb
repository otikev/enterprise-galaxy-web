class CreateBusinessForms < ActiveRecord::Migration[6.0]
  def change
    create_table :business_forms do |t|
      t.string :name
      t.timestamps
    end
  end
end
