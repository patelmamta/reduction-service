class ApplicationController < ActionController::API
	
	# Handle 500 Internal Server Error and log the exception
  rescue_from StandardError do |exception|
    logger.error exception.message
    logger.error exception.backtrace.join("\n")
    
    render json: { error: 'Internal server error' }, status: :internal_server_error
  end

  # Handle route not found (404)
	def route_not_found
		render json: {
			error: 'Route not found',
		}, status: :not_found
	end
end
