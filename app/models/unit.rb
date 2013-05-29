class Unit < ActiveRecord::Base
	has_many :components, :order => 'component_index'
	has_many :quizzes, :through => :components
	has_many :lectures, :through => :components

  attr_accessible :close_date, :name, :release_date
  validates :name, :presence => true

  def self.current
		Unit.where("release_date < ? AND close_date > ?", Time.now, Time.now)
  end

end
