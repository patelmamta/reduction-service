module Api::V1
  class RedactController < ApplicationController
    require 'logger'

    # Load redaction list from environment or fallback to default
    REDACTION_LIST = ENV['REDACTION_LIST']&.split(',') || ['confidential', 'secret']

    # Setup logger
    LOG_FILE_PATH = Rails.root.join('log', 'redact_requests.log')
    @@logger = Logger.new(LOG_FILE_PATH)

    # /redact
    def index
      render json: { 
        message: "The request has been executed successfully",
        result: "Redaction Service"
      }, status: :ok
    end

    # /redact
    def redact
      input_text = params[:redact_text]
      # Log the raw text with a timestamp
      @@logger.info("#{Time.now}: #{input_text}")

      redacted_text = redact_service(input_text)
  
      render json: { 
        message: "The request has been executed successfully",
        result: redacted_text,
      }, status: :ok
    end

    private

    # redacted service logic
    def redact_service(text)
      words = text.split()
      words.map { |word| 
        REDACTION_LIST.include?(word.downcase) ? 'REDACTED' : word
      }.join(' ')
    end
  end
end