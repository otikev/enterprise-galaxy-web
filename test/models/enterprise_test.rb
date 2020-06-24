# == Schema Information
#
# Table name: enterprises
#
#  id                        :integer          not null, primary key
#  business_form_id          :integer
#  broad_sector_name_id      :integer
#  business_name             :string
#  start_of_operations_date  :date
#  registration_date         :date
#  postal_address            :string
#  postal_code               :string
#  country                   :string
#  city                      :string
#  office_number             :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  user_id                   :integer
#  referral                  :string
#  office_mobile_number      :string
#  office_location_hq        :string
#  google_map_location       :string
#  main_sector               :string
#  sub_sector                :string
#  name_of_founder           :string
#  founder_mobile_number     :string
#  founder_gender            :string
#  founder_date_of_birth     :date
#  financial_year_start_date :string
#  financial_year_end_date   :string
#  mission                   :string
#  vision                    :string
#  punch_line                :string
#  brand_logo                :string
#  brief_service_description :string
#  num_employees_fulltime    :integer
#  num_employees_parttime    :integer
#  other_broad_sector        :string
#

require 'test_helper'

class EnterpriseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
