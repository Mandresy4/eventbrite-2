class Event < ApplicationRecord
  belongs_to :administrator, class_name: "User"
  has_many :attendances
  has_many :users, through: :attendances

  validates :start_date, presence: true, unless: :in_the_past?
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }, if: :duration_multiple_of_5?
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
  validates :location, presence: true
 
  def in_the_past?
    start_date < DateTime.now
  end

  def duration_multiple_of_5?
    duration % 5 == 0
  end
end
