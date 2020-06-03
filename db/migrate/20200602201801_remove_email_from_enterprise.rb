class RemoveEmailFromEnterprise < ActiveRecord::Migration[6.0]
  def change
    remove_column :enterprises, :contact_email, :string
    remove_column :enterprises, :activation_digest, :string
    remove_column :enterprises, :activated, :string
    remove_column :enterprises, :activated_at, :string
  end
end
