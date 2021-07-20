class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :rating

  validates :answer, presence: true, if: -> { question.required? }
end
