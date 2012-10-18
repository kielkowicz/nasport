# == Schema Information
#
# Table name: places
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  address     :string(255)
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  closed      :boolean         default(FALSE)
#

class Place < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  belongs_to :city
  
  has_attached_file :pix1, :styles => {:thumb => "100x100>", :big => "400x400>"}, 
                           :content_type => { :content_type => "image/jpg" },
                           :size => { :in => 0..100.kilobytes }
  
  has_attached_file :pix2, :styles => {:thumb => "100x100>", :big => "400x400>"}, 
                           :content_type => { :content_type => "image/jpg" },
                           :size => { :in => 0..100.kilobytes }
  
  has_attached_file :pix3, :styles => {:thumb => "100x100>", :big => "400x400>"}, 
                           :content_type => { :content_type => "image/jpg" },
                           :size => { :in => 0..100.kilobytes }
end
