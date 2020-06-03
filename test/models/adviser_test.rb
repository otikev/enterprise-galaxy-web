# == Schema Information
#
# Table name: advisers
#
#  id                      :integer          not null, primary key
#  name                    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :integer
#  nationality             :string
#  title                   :string
#  first_name              :string
#  other_names             :string
#  gender                  :string
#  date_of_birth           :date
#  country_of_residence    :string
#  po_box                  :string
#  city                    :string
#  cell_phone              :string
#  personal_email          :string
#  work_email              :string
#  preferred_mode_of_comms :string
#  employment_status       :string
#  current_employer        :string
#

require 'test_helper'

class AdviserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
