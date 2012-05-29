# == Schema Information
#
# Table name: disciplines
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  rules       :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Discipline < ActiveRecord::Base
end
