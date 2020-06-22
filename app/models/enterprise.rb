# == Schema Information
#
# Table name: enterprises
#
#  id                       :integer          not null, primary key
#  business_form_id         :integer
#  broad_sector_name_id     :integer
#  business_name            :string
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
#  user_id                  :integer
#  phone                    :string
#  referral                 :string
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
	validates :phone, :presence =>true
	validates :referral, :presence =>true

	def profile_completion_status
		total_data_points = 13.0
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
		if self.office_phone != nil
      completed_data_points+=1
    end
		if self.phone != nil
      completed_data_points+=1
    end
		if self.referral != nil
      completed_data_points+=1
    end

		((completed_data_points/total_data_points)*100).to_int
	end
end
