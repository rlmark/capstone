require 'rails_helper'

RSpec.describe ResponsesController, :type => :controller do

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET create" do
    it "returns http success" do
      post :create, { response: {transcript: "test transcript params", question_id: 1}
                    }
      expect(response.code).to_not be "4xx"
    end

    context "invalid params"
      it "does not save the response" do
        expect do
            post :create, { response: {transcript: "" }}
        end.not_to change(Response, :count)
      end

      it "renders new page with invalid params" do
        post :create, { response: {transcript: "" }}
        expect(response).to render_template "new"
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET update" do
    it "returns http success" do
      patch :update, {id: 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET destroy" do
    it "returns http success" do
      delete :destroy, {id: 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, {id: 1}
      expect(response).to have_http_status(:success)
    end
  end

end
