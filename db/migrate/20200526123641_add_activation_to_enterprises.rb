class AddActivationToEnterprises < ActiveRecord::Migration[6.0]
  def change
    add_column :enterprises, :activation_digest, :string
    add_column :enterprises, :activated, :boolean
    add_column :enterprises, :activated_at, :datetime
  end
end
