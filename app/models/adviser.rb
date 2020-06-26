# == Schema Information
#
# Table name: advisers
#
#  id                      :integer          not null, primary key
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

class Adviser < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :first_name, presence: true
  validates :other_names, presence: true
  validates :date_of_birth, presence: true
  validates :cell_phone, presence: true
  validates :country_of_residence, presence: true

  def profile_completion_status
    total_data_points = 15.0
    completed_data_points = 0
    completed_data_points += 1 unless current_employer.nil?
    completed_data_points += 1 unless employment_status.nil?
    completed_data_points += 1 unless preferred_mode_of_comms.nil?
    completed_data_points += 1 unless work_email.nil?
    completed_data_points += 1 unless personal_email.nil?
    completed_data_points += 1 unless cell_phone.nil?
    completed_data_points += 1 unless city.nil?
    completed_data_points += 1 unless po_box.nil?
    completed_data_points += 1 unless country_of_residence.nil?
    completed_data_points += 1 unless date_of_birth.nil?
    completed_data_points += 1 unless gender.nil?
    completed_data_points += 1 unless other_names.nil?
    completed_data_points += 1 unless first_name.nil?
    completed_data_points += 1 unless title.nil?
    completed_data_points += 1 unless nationality.nil?

    ((completed_data_points / total_data_points) * 100).to_int
  end
end
