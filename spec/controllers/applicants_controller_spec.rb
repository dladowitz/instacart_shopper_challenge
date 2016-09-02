require 'rails_helper'

describe ApplicantsController do
  describe "GET new" do
    subject { get :new }
    before  { subject }

    it "renders the  template" do
      expect(response).to render_template :new
    end

    it "returns http success" do
      expect(response.status).to be 200
    end

    it "creates a new applicant object" do
      expect(assigns(:applicant)).to be_an_instance_of Applicant
    end
  end


  describe "POST create" do
    context "With valid params" do
      let(:valid_applicant_params) { { first_name: "Tony", last_name: "Stark", email: "tony@starklabs.com", phone: "415 111 2222", phone_type: "iPhone 6/6 Plus", region: "San Francisco Bay Area" } }
      subject { post :create, applicant:  valid_applicant_params }

      it "creates a new applicant in the database" do
        expect{ subject }.to change { Applicant.count}.by 1
      end
    end

    context "With invalid params" do
      let(:invalid_applicant_params) { { first_name: "Tony", last_name: "Stark"  } }
      subject { post :create, applicant:  invalid_applicant_params }

      it "does not create a new applicant in the database" do
        expect{ subject }.not_to change { Applicant.count}
      end
    end
  end
end
