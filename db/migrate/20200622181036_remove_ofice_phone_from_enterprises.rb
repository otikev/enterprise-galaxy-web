class RemoveOficePhoneFromEnterprises < ActiveRecord::Migration[6.0]
  def change
    remove_column :enterprises, :office_phone, :string
  end
end
