class AddPhoneAndReferralToEnterprises < ActiveRecord::Migration[6.0]
  def change
    add_column :enterprises, :phone, :string
    add_column :enterprises, :referral, :string
  end
end
