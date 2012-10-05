# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  first_name :string(255)      not null
#  last_name  :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Person < ActiveRecord::Base


  attr_accessible :first_name, :last_name

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  before_save :cleanup

  scope :all_lazy, select("*")
  scope :find_lazy, lambda {|id| where(primary_id => id)}
  scope :all_ordered_last, all_lazy.order("last_name ASC")

  def name
  	"#{first_name} #{last_name}"
  end

  def cleanup
  	self[:first_name] = self[:first_name].capitalize
  end
end
