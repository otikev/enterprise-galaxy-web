class CreateAdvisers < ActiveRecord::Migration[6.0]
  def change
    create_table :advisers do |t|
      t.string :name
      t.string :string

      t.timestamps
    end
  end
end
