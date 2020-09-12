class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user,only: [:update]
  before_action :correct_user,only: [:update]

  def index
    users = User.all
    json_users = UserSerializer.new(users).serialized_json
    render json: json_users
  end

  def show
    user = User.find_by(id: params[:id])
    json_user = UserSerializer.new(user).serialized_json
    render json: json_user
  end

  def create
    user = User.new(sign_up_params)
    if user.save
      json_user = UserSerializer.new(user).serialized_json
      render json: json_user
    else
      render json: {
          message: "ERROR OCCURED"
      }
    end
  end

  def update
    user = User.find_by(id: params[:id])
    if user.update_attributes(update_params)
      json_user = UserSerializer.new(user).serialized_json
      render json: json_user
    else
      render json: {
          message: "ERROR OCCURED"
      }
    end
  end

  def destroy; end

  private
  
  def sign_up_params
    params.permit(:email,:password,:password_confirmation,:name)
  end

  def update_params
    params.permit(:name,:avatar,:introduction)
  end

  def correct_user
    user = User.find_by(id: params[:id])
    if user != current_user
      render json: {
          message: "UnAuthorization"
      }
    end
  end

end
