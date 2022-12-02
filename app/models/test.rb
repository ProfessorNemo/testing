class Test < ApplicationRecord
  belongs_to :attempt
  belongs_to :question
  belongs_to :answer
end
