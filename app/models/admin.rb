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

class Admin < ApplicationRecord
  belongs_to :user
end
