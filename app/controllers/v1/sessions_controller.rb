class V1::SessionsController < ApplicationController
  skip_before_action :authorize_request, only: [:create, :token]

  def create
    user = User.find_by username: params[:username]
    if user&.authenticate(params[:password])
      time = Time.now + 1.week.to_i
      token = JsonWebToken.encode(user_id: user.id, exp: time)
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                      username: user.username }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def token
    decoded = JsonWebToken.decode(bearer_token)
    prev_time = Time.at(decoded[:exp])
    if prev_time >= Time.now && @user = User.find(decoded[:user_id]) 
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.username }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def show
  end

  def destroy
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    header.gsub(pattern, '') if header && header.match(pattern)
  end
end