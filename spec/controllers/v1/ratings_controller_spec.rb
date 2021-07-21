require 'rails_helper'

RSpec.describe V1::RatingsController, type: :controller do
  let(:valid_attributes) {
    {
      rate: "5"
    }
  }

  let(:invalid_attributes) {
    {
      ratee: "5"
    }
  }

  let(:invalid_rate) {
    {
      rate: nil
    }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns an HTTP Status 200 response" do
      get :index, params: {}, session: valid_session
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "returns an HTTP Status 201 response" do
      post :create, params: valid_attributes, session: valid_session
      expect(response).to have_http_status(201)
    end
  end

  describe "POST #create" do
    it "returns an HTTP Status 422 response due to incorrect attributes" do
      post :create, params: invalid_attributes, session: valid_session
      expect(response).to have_http_status(422)
    end
  end

  describe "POST #create" do
    it "returns an HTTP Status 422 response due to empty parameters" do
      post :create, params: {}, session: valid_session
      expect(response).to have_http_status(422)
    end
  end

  describe "POST #create" do
    it "returns an HTTP Status 422 response due to invalid rate" do
      post :create, params: invalid_rate, session: valid_session
      expect(response).to have_http_status(422)
    end
  end
end