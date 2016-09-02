require 'rails_helper'

describe ApplicantsController do
  describe "GET index" do
    subject { get :index }
    before  { subject }

    it "renders the index template" do
      expect(response).to render_template :index
    end

    it "returns http success" do
      expect(response.status).to be 200
    end
  end
end
