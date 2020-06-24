# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  email                 :string
#  password_hash         :string
#  password_salt         :string
#  auth_token            :string
#  activation_token      :string
#  enabled               :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  two_factor            :boolean          default("true")
#  activated_at          :datetime
#  activated             :boolean          default("false")
#  google_secret         :string
#  mfa_secret            :string
#  failed_login_attempts :integer          default("0")
#  unlock_token          :string
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
