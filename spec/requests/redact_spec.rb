# spec/requests/redact_spec.rb

require 'rails_helper'

RSpec.describe "Redact API", type: :request do
  describe "GET /api/v1/redact" do
    it "returns the service name" do
      get '/api/v1/redact'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq({
        "result" => 'Redaction Service',
        "message" => 'The request has been executed successfully'
      })
    end
  end

  describe "POST /api/v1/redact" do
    context "with words that need redaction" do
      it "returns redacted text" do
        # Set environment variable for redaction list if needed
        allow(ENV).to receive(:[]).with('REDACTION_LIST').and_return('confidential,secret')

        post '/api/v1/redact', params: { redact_text: "This is a confidential document" }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({
          "result" => 'This is a REDACTED document',
          "message" => 'The request has been executed successfully'
        })
      end
    end

    context "with no words that need redaction" do
      it "returns the original text" do
        post '/api/v1/redact', params: { redact_text: "This is a public document" }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({
          "result" => 'This is a public document',
          "message" => 'The request has been executed successfully'
        })
      end
    end

    context "with no params that return internal server error" do
      it "returns the original text" do
        post '/api/v1/redact'
        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)).to eq({
          "error" => 'Internal server error',
        })
      end
    end
  end

  describe "POST /api/v1/redact/test" do
    context "with no routes" do
      it "returns route is not found" do
        # Set environment variable for redaction list if needed
        allow(ENV).to receive(:[]).with('REDACTION_LIST').and_return('confidential,secret')

        post '/api/v1/redact/test', params: { redact_text: "This is a confidential document" }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({
          "error" => 'Route not found'
        })
      end
    end
  end
end
