# == Schema Information
#
# Table name: advisers
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

require 'test_helper'

class AdviserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
