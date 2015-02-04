require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    it "returns http success" do
      post :create, { question: {content: "test question", private: true},
                    "talking_point" => {"phrase" => ["My talking point"]}
                    }
      expect(response).to_not be("400")
    end

    it "redirects to the new_recording path" do
      post :create, { question: {content: "test question", private: true},
                    "talking_point" => {"phrase" => ["My talking point"]}
                    }
      expect(response.code).to eq "302"
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, {id: 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH update" do
    it "returns http success" do
      patch :update, {id: 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE destroy" do
    it "returns http success" do
      delete :destroy, {id: 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: 1}
      expect(response).to have_http_status(:success)
    end
  end

end
