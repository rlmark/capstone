require 'rails_helper'

RSpec.describe ResultsController, :type => :controller do

  describe "GET show" do
    it "is not an error" do
      get :show, nil, session: {response_id: 27}
      expect(response.code).to_not be "4xx"
    end

    it "displays page" do
      get :show, nil, session: {response_id: 27}
      expect(response).to have_http_status(:success)
    end
  end

end
