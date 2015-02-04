require 'rails_helper'

RSpec.describe ResultsController, :type => :controller do

  describe "GET show" do
    it "returns http success" do
      get :show, {response_id: 27}
      expect(response.code).to_not be "4xx"
    end

    it "is successful" do
      get :show, {response_id: 27}
      expect(response).to have_http_status(:success)
    end
  end

end
