class Question < ActiveRecord::Base
  has_many :responses

  # enumerize :type, in: { short_answer: 0, email: 1, linear_scale: 2 }
end
