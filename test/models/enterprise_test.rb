# == Schema Information
#
# Table name: enterprises
#
#  id                       :integer          not null, primary key
#  business_form_id         :integer
#  broad_sector_name_id     :integer
#  business_name            :string
#  contact_email            :string
#  start_of_operations_date :date
#  registration_date        :date
#  postal_address           :string
#  postal_code              :string
#  country                  :string
#  city                     :string
#  office_number            :string
#  office_phone             :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  activation_digest        :string
#  activated                :boolean
#  activated_at             :datetime
#

require 'test_helper'

class EnterpriseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
