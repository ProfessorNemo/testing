class Subject < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :attempts, dependent: :destroy
  validates :name_subject, presence: true, uniqueness: true
end
