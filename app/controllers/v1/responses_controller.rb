class V1::ResponsesController < ApplicationController
  def index
    responses = Response.select(permitted_parameters)
    
    render json: { success: true, responses: responses }, status: :ok
  rescue Exception => e
    render json: { success: false, error: e.message }, status: :unprocessable_entity
  end

  def create
    response = Response.create(payload)
    
    render json: { success: true }, status: :created
  rescue Exception => e
    render json: { success: false, error: e.message }, status: :unprocessable_entity
  end

  protected

  def permitted_parameters
    [:rating_id, :question_id, :answer]
  end

  private

  def payload
    @payload ||= params.permit(permitted_parameters).as_json
  end
end
