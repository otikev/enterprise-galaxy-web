class ChangeDefaultValueForTwoFactor < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :two_factor, :true
  end
end
