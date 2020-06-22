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

	validates :business_name, :presence =>true
	validates :business_form_id, :presence =>true
	validates :broad_sector_name_id, :presence =>true
	validates :registration_date, :presence =>true
	validates :start_of_operations_date, :presence =>true
	validates :country, :presence =>true
	validates :referral, :presence =>true

	def profile_completion_status
		total_data_points = 30.0
		completed_data_points = 0
		if self.business_form_id != nil
      completed_data_points+=1
    end
		if self.broad_sector_name_id != nil
      completed_data_points+=1
    end
		if self.business_name != nil
      completed_data_points+=1
    end
		if self.start_of_operations_date != nil
      completed_data_points+=1
    end
		if self.registration_date != nil
      completed_data_points+=1
    end
		if self.postal_address != nil
      completed_data_points+=1
    end
		if self.postal_code != nil
      completed_data_points+=1
    end
		if self.country != nil
      completed_data_points+=1
    end
		if self.city != nil
      completed_data_points+=1
    end
		if self.office_number != nil
      completed_data_points+=1
    end
		if self.referral != nil
      completed_data_points+=1
    end
		if self.office_mobile_number != nil
      completed_data_points+=1
    end
		if self.office_location_hq != nil
      completed_data_points+=1
    end
		if self.google_map_location != nil
      completed_data_points+=1
    end
		if self.main_sector != nil
      completed_data_points+=1
    end
		if self.sub_sector != nil
      completed_data_points+=1
    end
		if self.name_of_founder != nil
      completed_data_points+=1
    end
		if self.founder_mobile_number != nil
      completed_data_points+=1
    end
		if self.founder_gender != nil
      completed_data_points+=1
    end
		if self.founder_date_of_birth != nil
      completed_data_points+=1
    end
		if self.financial_year_start_date != nil
      completed_data_points+=1
    end
		if self.financial_year_end_date != nil
      completed_data_points+=1
    end
		if self.mission != nil
      completed_data_points+=1
    end
		if self.vision != nil
      completed_data_points+=1
    end
		if self.punch_line != nil
      completed_data_points+=1
    end
		if self.brand_logo != nil
      completed_data_points+=1
    end
		if self.brief_service_description != nil
      completed_data_points+=1
    end
		if self.num_employees_fulltime != nil
      completed_data_points+=1
    end
		if self.num_employees_parttime != nil
      completed_data_points+=1
    end

		((completed_data_points/total_data_points)*100).to_int
	end
end
