class V1::UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  def show
    render json: @current_user, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    unless @current_user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username, :first_name, :last_name, :email, :password, :password_confirmation
    )
  end
end