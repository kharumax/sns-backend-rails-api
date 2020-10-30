class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user,only: [:update,:mypage]
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

  def mypage
    posts = PostSerializer.new(current_user.get_posts).serialized_json
    liked_posts = PostSerializer.new(current_user.get_liked_posts).serialized_json
    following_cnt = current_user.following.count
    follower_cnt =  current_user.followers.count
    user_info = UserSerializer.new(current_user).serialized_json
    render json: {
        success: true,
        message: "Get Mypage Information Success",
        data: {
            posts: posts,
            liked_posts: liked_posts,
            following_cnt: following_cnt,
            follower_cnt: follower_cnt,
            user_info: user_info
        }
    }
  end

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
