# == Schema Information
#
# Table name: password_requests
#
#  id         :integer          not null, primary key
#  token      :string
#  expiry     :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  used       :boolean          default("false")
#

require 'test_helper'

class PasswordRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
