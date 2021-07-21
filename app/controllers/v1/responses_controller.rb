class V1::ResponsesController < ApplicationController
  def index
    responses = Response.select(select_parameters)
    
    render json: { success: true, responses: responses }, status: :ok
  rescue Exception => e
    render json: { success: false, error: e.message },
           status: :unprocessable_entity
  end

  def create
    return render json: { success: false },
                  status: :bad_request unless complete_params?

    return render json: { success: false },
                  status: :not_found unless rating_found?    
    
    return render json: { success: false },
                  status: :not_found if no_questions_found?

    result = responses.map.each do |question_id, answer|
      create_response(question_id, answer)
    end

    result.reject!(&:blank?)

    render json: { success: result.present?, responses: result },
           status: result.present? ? :created : :unprocessable_entity
  rescue Exception => e
    render json: { success: false, error: e.message },
           status: :unprocessable_entity
  end

  protected

  def select_parameters
    [:id, :rating_id, :question_id, :answer]
  end

  def permitted_parameters
    [:rating_id, responses: {}]
  end

  private

  def create_response(question_id, answer)
    question = Question.find_by(id: question_id)

    return unless question.present? && answer.present?

    response = Response.create(
      rating_id: rating_id,
      question_id: question_id,
      answer: answer)

    { question: question.text, answer: response.answer } if response.id?
  end

  def rating_found?
    Rating.find_by(id: rating_id).present?
  end

  def no_questions_found?
    questions = Question.where(id: responses.keys)

    questions.count == 0
  end

  def complete_params?
    rating_id.present? && responses.present?
  end

  def rating_id
    @rating_id ||= payload["rating_id"]
  end

  def responses
    @responses ||= payload["responses"]
  end

  def payload
    @payload ||= params.permit(permitted_parameters).as_json
  end
end
