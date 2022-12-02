class Student < ApplicationRecord
  has_many :attempts, dependent: :destroy
  validates :name_student, presence: true, uniqueness: true
end
