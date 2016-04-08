require 'rails_helper'

RSpec.describe "Pulls API" do
  let!(:pr) { create :pull_request, pending_reviews: %w(aergonaut BrentW), completed_reviews: %w(mrpasquini) }

  describe "GET /repos/:repo/pulls/:number/reviewers" do
    it "returns the list of pending reviewers" do
      get "/repos/aergonaut/testrepo/pulls/#{pr.number}/reviewers"

      expect(response.status).to be(200)
      expect(json_body).to be_a(Array)
      expect(json_body).to contain_exactly("aergonaut", "BrentW")
    end

    it "returns the list of completed reviewers if the status parameter is completed" do
      get "/repos/aergonaut/testrepo/pulls/#{pr.number}/reviewers?status=completed"

      expect(json_body).to contain_exactly("mrpasquini")
    end

    it "returns 404 for a PR that can't be found" do
      get "/repos/octocat/spoonknife/pulls/#{pr.number}/reviewers"

      expect(response.status).to be(404)
    end
  end

  describe "POST /repos/:repo/pulls/:number/reviewers/add" do
    it "adds the specified reviewers to the list of pending reviews" do
      post "/repos/aergonaut/testrepo/pulls/#{pr.number}/reviewers/add", "[\"saghaulor\"]"

      expect(response.status).to be(200)
      expect(pr.reload.pending_reviews).to contain_exactly("aergonaut", "BrentW", "saghaulor")
    end
  end
end
