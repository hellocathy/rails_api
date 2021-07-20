class V1::RatingsController < ApplicationController
  def index
    ratings = Rating.select([:id] + permitted_parameters)
    
    render json: { success: true, ratings: ratings }, status: :ok
  rescue Exception => e
    render json: { success: false, error: e.message }, status: :unprocessable_entity
  end

  def create
    rating = Rating.create(payload)

    render json: { success: true, id: rating.id }, status: :created
  rescue Exception => e
    render json: { success: false, error: e.message }, status: :unprocessable_entity
  end

  def report
    ratings = (minimum_rate..maximum_rate).map{ |rate| { "#{rate}" => 0 }}.inject(:merge)
    ratings = ratings.merge(Rating.order(rate: :asc).group(:rate).count)

    render json: { rating_breakdown: ratings }, status: :ok
  rescue Exception => e
    render json: { success: false, error: e.message }, status: :unprocessable_entity
  end

  protected

  def permitted_parameters
    [:rate]
  end

  private

  def minimum_rate
    Rating::MINIMUM_RATE
  end

  def maximum_rate
    Rating::MAXIMUM_RATE
  end

  def payload
    @payload ||= params.permit(permitted_parameters).as_json
  end
end
