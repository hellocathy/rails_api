class V1::ResponsesController < ApplicationController
  def create
    response = Response.create(payload)
    head :created
  rescue Exception => e
    render json: e.message, status: :unprocessable_entity
  end

  def index
    responses = []
    Response.find_each do |response|
      ratings << response.slice("answer")
    end

    render json: responses, status: :ok
  end

  private

  def payload
    @payload ||= params.permit(:answer).as_json
  end
end
