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
#

class User < ApplicationRecord
end
