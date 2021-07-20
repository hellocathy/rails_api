class V1::QuestionsController < ApplicationController
  def index
    questions = Question.select([:id] + permitted_parameters)

    render json: { success: true, questions: questions }, status: :ok
  rescue Exception => e
    render json: { success: false, error: e.message }, status: :unprocessable_entity
  end

  def create
    question = Question.create(payload)

    render json: { success: true }, status: :created
  rescue Exception => e
    render json: { success: false, error: e.message }, status: :unprocessable_entity
  end

  def update
    question = Question.find_by(id: params["id"])

    return head :not_found if question.blank?

    return head :bad_request if payload.blank?

    render json: { success: question.update(payload) }, status: :ok
  rescue Exception => e
    render json: { success: false, error: e.message }, status: :unprocessable_entity
  end

  def destroy
    question = Question.find_by(id: params["id"])

    return head :not_found unless question.present?

    question.destroy

    head :ok
  rescue Exception => e
    render json: { success: false, error: e.message }, status: :unprocessable_entity
  end

  protected

  def permitted_parameters
    [:text, :question_type, :placeholder, :required]
  end

  private

  def payload
    @payload ||= params.permit(permitted_parameters).as_json
  end
end
