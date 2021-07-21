require 'rails_helper'

RSpec.describe V1::ResponsesController, type: :controller do
  let(:non_existing_rating) {
    {
      rating_id: 8343292,
      responses: {
        "1"=>"Test Answer 1",
        "2"=>"Test Answer 2",
        "3"=>"Test Answer 3"
      }
    }
  }

  let(:responses_only) {
    {
      responses: {
        "1"=>"Test Answer 1",
        "2"=>"Test Answer 2",
        "3"=>"Test Answer 3"
      }
    }
  }

  let(:valid_question_attributes) {
    {
      text: "This is a test question",
      question_type: "short_answer",
      placeholder: "This is a test placeholder",
      required: true
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
    it "returns an HTTP Status 400 response due to empty parameters" do
      post :create, params: {}, session: valid_session
      expect(response).to have_http_status(400)
    end
  end

  describe "POST #create" do
    it "returns an HTTP Status 404 response due to no responses parameter" do
      rating = Rating.create(rate: 5)

      post :create, params: { rating_id: rating.id }, session: valid_session
      expect(response).to have_http_status(400)
    end
  end

  describe "POST #create" do
    it "returns an HTTP Status 404 response due to no rating_id parameter" do
      post :create, params: responses_only, session: valid_session
      expect(response).to have_http_status(400)
    end
  end

  describe "POST #create" do
    it "returns an HTTP Status 404 response due to rating not found" do
      post :create, params: non_existing_rating, session: valid_session
      expect(response).to have_http_status(404)
    end
  end

  describe "POST #create" do
    it "returns an HTTP Status 404 response due to no questions found" do
      rating = Rating.create(rate: 5)

      post :create, params: {
        rating_id: rating.id,
        responses: {
          "3115221"=>"Test Answer 1",
          "4524132"=>"Test Answer 2",
          "3459943"=>"Test Answer 3"
        }
      }, session: valid_session
      expect(response).to have_http_status(404)
    end
  end

  describe "POST #create" do
    it "returns an HTTP Status 422 response due to missing answer" do
      rating = Rating.create(rate: 5)
      question = Question.create(valid_question_attributes)

      post :create, params: {
        rating_id: rating.id,
        responses: {
          "#{question.id}" => ""
        }
      }, session: valid_session
      expect(response).to have_http_status(422)
    end
  end

  describe "POST #create" do
    it "returns an HTTP Status 200" do
      rating = Rating.create(rate: 5)
      question = Question.create(valid_question_attributes)

      post :create, params: {
        rating_id: rating.id,
        responses: {
          "#{question.id}" => "Sample answer"
        }
      }, session: valid_session
      expect(response).to have_http_status(201)
    end
  end
end