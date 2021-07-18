class V1::QuestionsController < ApplicationController
  def index
    questions = []
    Question.find_each do |question|
      questions << question.slice("id", "text", "question_type", "placeholder", "required")
    end

    render json: questions, status: :ok
  end

  def create
    question = Question.create(payload)

    render json: { success: true, question_id: question.id }, status: :created
  rescue Exception => e
    render json: e.message, status: :unprocessable_entity
  end

  def update
    question = Question.find_by(id: params["id"])
    question.update(payload)

    head :ok
  rescue Exception => e
    head :unprocessable_entity
  end

  def destroy
    question = Question.find_by(id: params["id"])

    if question.present?
      question.destroy
      head :ok
    else
      head :not_found
    end
  rescue Exception => e
    head :unprocessable_entity
  end

  private

  def payload
    @payload ||= params.permit(:text, :question_type, :placeholder, :required).as_json
  end
end
