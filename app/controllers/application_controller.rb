class ApplicationController < ActionController::API
  include Trailblazer::Rails::Controller
  before_action :authorize_request

  def current_user
    @current_user
  end

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    decoded = JsonWebToken.decode(bearer_token)
    prev_time = Time.at(decoded[:exp])
    if prev_time >= Time.now && user = User.find(decoded[:user_id]) 
      @current_user = user
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    header.gsub(pattern, '') if header && header.match(pattern)
  end

  # trailblazer, to inject current_user 
  private 
  def _run_options(options)
    options.merge(
      current_user: current_user
    )
  end

end
