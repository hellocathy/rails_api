class Question < ActiveRecord::Base
  has_many :responses

  validates :question_type, inclusion: { in: %w(short_answer email linear_scale) }
end
