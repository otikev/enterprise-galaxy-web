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

class Adviser < ApplicationRecord
  belongs_to :user
end
