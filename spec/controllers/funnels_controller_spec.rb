require 'rails_helper'

describe FunnelsController do
  describe "GET index" do
    subject { get :index, start_date: "2014-12-01", end_date: "2014-12-14", format: :json }
    before  do
      Applicant.create updated_at: DateTime.new(2014, 12, 02), first_name: "Tony", last_name: "Stark", email: "tony@starklabs.com", phone: "415 111 2222", phone_type: "iPhone 6/6 Plus", region: "San Francisco Bay Area", workflow_state: "applied"
      Applicant.create updated_at: DateTime.new(2014, 12, 10), first_name: "Thor", last_name: "Asgard", email: "thor@asgard.com", phone: "415 222 3333", phone_type: "iPhone 6/6 Plus", region: "San Francisco Bay Area", workflow_state: "hired"
      Applicant.create updated_at: DateTime.new(2014, 12, 15), first_name: "Bruce", last_name: "Banner", email: "bruce@banner.com", phone: "415 333 4444", phone_type: "iPhone 6/6 Plus", region: "San Francisco Bay Area", workflow_state: "rejected"
      subject
    end

    it "should respond with http success" do
      expect(response.status).to be 200
    end

    it "should return json with two buckets" do
      results = JSON.parse response.body
      expect(results.count).to eq 2
    end
  end
end
