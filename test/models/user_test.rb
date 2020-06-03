# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string
#  password_hash           :string
#  password_salt           :string
#  auth_token              :string
#  activated               :string
#  activation_token        :string
#  activation_token_expiry :date
#  enabled                 :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  two_factor              :boolean          default("false")
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
