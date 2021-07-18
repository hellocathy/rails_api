class Question
	def create(params)
		return false unless complete_parameters?
		question = Question.new(params)
		question.save
	rescue Exception => e
		false
	end

	private

	def complete_parameters?
		params.length == 4
		&& has_text?
		&& has_question_type?
		&& has_placeholder?
		&& has_required?
	end

	def has_text?
		params[:text].present?
	end

	def has_question_type?
		params[:question_type].present?
	end

	def has_placeholder?
		params[:placeholder].present?
	end

	def has_required?
		params[:required].present?
	end
end
