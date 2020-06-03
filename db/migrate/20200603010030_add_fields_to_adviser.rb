class AddFieldsToAdviser < ActiveRecord::Migration[6.0]
  def change
    add_column :advisers, :nationality, :string
    add_column :advisers, :title, :string
    add_column :advisers, :first_name, :string
    add_column :advisers, :other_names, :string
    add_column :advisers, :gender, :string
    add_column :advisers, :date_of_birth, :date
    add_column :advisers, :country_of_residence, :string
    add_column :advisers, :po_box, :string
    add_column :advisers, :city, :string
    add_column :advisers, :cell_phone, :string
    add_column :advisers, :personal_email, :string
    add_column :advisers, :work_email, :string
    add_column :advisers, :preferred_mode_of_comms, :string
    add_column :advisers, :employment_status, :string
    add_column :advisers, :current_employer, :string
  end
end
