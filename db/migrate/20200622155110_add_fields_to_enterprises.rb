class AddFieldsToEnterprises < ActiveRecord::Migration[6.0]
  def change
    remove_column :enterprises, :phone, :string
    add_column :enterprises, :office_mobile_number, :string
    add_column :enterprises, :office_location_hq, :string
    add_column :enterprises, :google_map_location, :string
    add_column :enterprises, :main_sector, :string
    add_column :enterprises, :sub_sector, :string
    add_column :enterprises, :name_of_founder, :string
    add_column :enterprises, :founder_mobile_number, :string
    add_column :enterprises, :founder_gender, :string
    add_column :enterprises, :founder_date_of_birth, :date
    add_column :enterprises, :financial_year_start_date, :string
    add_column :enterprises, :financial_year_end_date, :string
    add_column :enterprises, :mission, :string
    add_column :enterprises, :vision, :string
    add_column :enterprises, :punch_line, :string
    add_column :enterprises, :brand_logo, :string
    add_column :enterprises, :brief_service_description, :string
    add_column :enterprises, :num_employees_fulltime, :integer
    add_column :enterprises, :num_employees_parttime, :integer
  end
end
