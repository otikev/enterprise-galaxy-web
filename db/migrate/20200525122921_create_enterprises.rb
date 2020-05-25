class CreateEnterprises < ActiveRecord::Migration[6.0]
  def change
    create_table :enterprises do |t|
      t.belongs_to :business_form
      t.belongs_to :broad_sector_name
      t.string :business_name
      t.string :contact_email
      t.date :start_of_operations_date
      t.date :registration_date
      t.string :postal_address
      t.string :postal_code
      t.string :country
      t.string :city
      t.string :office_number
      t.string :office_phone

      t.timestamps
    end
  end
end
