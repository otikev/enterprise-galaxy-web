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

  validates :title, :presence =>true
  validates :first_name, :presence =>true
  validates :other_names, :presence =>true
  validates :date_of_birth, :presence =>true
  validates :cell_phone, :presence =>true
  validates :country_of_residence, :presence =>true

  def get_title
    #[['Mr.',1],['Mrs.',2],['Ms.',3],['Dr.',4],['Rev.',4]]
    title_string = ""
    if self.title.eql? "1"
      title_string = "Mr."
    elsif self.title.eql? "2"
      title_string = "Mrs."
    elsif self.title.eql? "3"
      title_string = "Ms."
    elsif self.title.eql? "4"
      title_string = "Dr."
    elsif self.title.eql? "5"
      title_string = "Rev."
    end
    title_string
  end

  def profile_completion_status
    total_data_points = 15.0
    completed_data_points = 0
    if self.current_employer != nil
      completed_data_points+=1
    end
    if self.employment_status != nil
      completed_data_points+=1
    end
    if self.preferred_mode_of_comms != nil
      completed_data_points+=1
    end
    if self.work_email != nil
      completed_data_points+=1
    end
    if self.personal_email != nil
      completed_data_points+=1
    end
    if self.cell_phone != nil
      completed_data_points+=1
    end
    if self.city != nil
      completed_data_points+=1
    end
    if self.po_box != nil
      completed_data_points+=1
    end
    if self.country_of_residence != nil
      completed_data_points+=1
    end
    if self.date_of_birth != nil
      completed_data_points+=1
    end
    if self.gender != nil
      completed_data_points+=1
    end
    if self.other_names != nil
      completed_data_points+=1
    end
    if self.first_name != nil
      completed_data_points+=1
    end
    if self.title != nil
      completed_data_points+=1
    end
    if self.nationality != nil
      completed_data_points+=1
    end

    ((completed_data_points/total_data_points)*100).to_int
  end
end
