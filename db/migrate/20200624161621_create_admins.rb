class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :first_name
      t.string :other_names
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
