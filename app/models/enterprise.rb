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
#

class Enterprise < ApplicationRecord
  belongs_to :user

  has_one :business_form
  has_one :broad_sector_name

  validates :business_name, presence: true
  validates :business_form_id, presence: true
  validates :broad_sector_name_id, presence: true
  validates :registration_date, presence: true
  validates :start_of_operations_date, presence: true
  validates :country, presence: true
  validates :referral, presence: true

  def profile_completion_status
    total_data_points = 30.0
    completed_data_points = 0
    completed_data_points += 1 unless business_form_id.nil?
    completed_data_points += 1 unless broad_sector_name_id.nil?
    completed_data_points += 1 unless business_name.nil?
    completed_data_points += 1 unless start_of_operations_date.nil?
    completed_data_points += 1 unless registration_date.nil?
    completed_data_points += 1 unless postal_address.nil?
    completed_data_points += 1 unless postal_code.nil?
    completed_data_points += 1 unless country.nil?
    completed_data_points += 1 unless city.nil?
    completed_data_points += 1 unless office_number.nil?
    completed_data_points += 1 unless referral.nil?
    completed_data_points += 1 unless office_mobile_number.nil?
    completed_data_points += 1 unless office_location_hq.nil?
    completed_data_points += 1 unless google_map_location.nil?
    completed_data_points += 1 unless main_sector.nil?
    completed_data_points += 1 unless sub_sector.nil?
    completed_data_points += 1 unless name_of_founder.nil?
    completed_data_points += 1 unless founder_mobile_number.nil?
    completed_data_points += 1 unless founder_gender.nil?
    completed_data_points += 1 unless founder_date_of_birth.nil?
    completed_data_points += 1 unless financial_year_start_date.nil?
    completed_data_points += 1 unless financial_year_end_date.nil?
    completed_data_points += 1 unless mission.nil?
    completed_data_points += 1 unless vision.nil?
    completed_data_points += 1 unless punch_line.nil?
    completed_data_points += 1 unless brand_logo.nil?
    completed_data_points += 1 unless brief_service_description.nil?
    completed_data_points += 1 unless num_employees_fulltime.nil?
    completed_data_points += 1 unless num_employees_parttime.nil?

    ((completed_data_points / total_data_points) * 100).to_int
  end
end
