require 'rails_helper'

RSpec.describe V1::QuestionsController, type: :controller do
  let(:valid_attributes) {
    {
      text: "This is a test question",
      question_type: "short_answer",
      placeholder: "This is a test placeholder",
      required: true
    }
  }

  let(:invalid_attributes) {
    {
      textt: "This is a test question",
      question_type: "This is a test question type",
      placeholder: "This is a test placeholder",
      required: true
    }
  }

  let(:missing_question_type) {
    {
      text: "This is a test question",
      placeholder: "This is a test placeholder",
      required: true
    }
  }

  let(:invalid_question_type) {
    {
      text: "This is a test question",
      question_type: "This is a test question type",
      placeholder: "This is a test placeholder",
      required: true
    }
  }

  let(:non_existing_id) {
    {
      id: 1382911
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
    it "returns an HTTP Status 422 response due to missing question type" do
      post :create, params: missing_question_type, session: valid_session
      expect(response).to have_http_status(422)
    end
  end

  describe "POST #create" do
    it "returns an HTTP Status 422 response due to invalid question type" do
      post :create, params: invalid_question_type, session: valid_session
      expect(response).to have_http_status(422)
    end
  end

  describe "PUT #update" do
    it "returns an HTTP Status 404 response due to update of non existing question" do
      put :update, params: non_existing_id, session: valid_session
      expect(response).to have_http_status(404)
    end
  end

  describe "PUT #update" do
    it "returns an HTTP Status 400 response due to update using an invalid attribute" do
      question = Question.create(valid_attributes)

      put :update, params: { id: question.id }, session: valid_session
      expect(response).to have_http_status(400)
    end
  end

  describe "PUT #update" do
    it "returns an HTTP Status 422 response due to update using an invalid question type" do
      question = Question.create(valid_attributes)

      put :update, params: { id: question.id, question_type: "question_type" }, session: valid_session
      expect(response).to have_http_status(422)
    end
  end

  describe "PUT #update" do
    it "returns an HTTP Status 200 response" do
      question = Question.create(valid_attributes)

      put :update, params: { id: question.id, question_type: "linear_scale" }, session: valid_session
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE #destroy" do
    it "returns an HTTP Status 404 response due to non existing question" do
      delete :destroy, params: { id: non_existing_id[:id] }, session: valid_session
      expect(response).to have_http_status(404)
    end
  end

  describe "DELETE #destroy" do
    it "returns an HTTP Status 200 response" do
      question = Question.create(valid_attributes)

      delete :destroy, params: { id: question.id }, session: valid_session
      expect(response).to have_http_status(200)
    end
  end
end