# == Schema Information
#
# Table name: admins
#
#  id          :integer          not null, primary key
#  first_name  :string
#  other_names :string
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
