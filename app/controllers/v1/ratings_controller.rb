class V1::RatingsController < ApplicationController
  def create
    rating = Rating.create(payload)
    render json: { success: true, id: rating.id, rate: rating.rate }, status: :created
  rescue Exception => e
    render json: e.message, status: :unprocessable_entity
  end

  def index
    ratings = []
    Rating.find_each do |rating|
      ratings << rating.slice("id", "rate")
    end

    render json: ratings, status: :ok
  end

  def report
    ratings = (minimum_rate..maximum_rate).map{ |rate| { "#{rate}" => 0 }}.inject(:merge)
    ratings = ratings.merge(Rating.order(rate: :asc).group(:rate).count)

    render json: { rating_breakdown: ratings }, status: :ok
  end

  private

  def minimum_rate
    Rating::MINIMUM_RATE
  end

  def maximum_rate
    Rating::MAXIMUM_RATE
  end

  def payload
    @payload ||= params.permit(:rate).as_json
  end
end
