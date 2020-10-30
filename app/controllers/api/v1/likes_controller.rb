class Api::V1::LikesController < ApplicationController
  before_action :check_liked, only: [:create]
  before_action :already_liked,only: [:destroy]
  before_action :authenticate_user

  def create
    post = Post.find_by(id: params[:post_id])
    like = Like.new(user_id: current_user,post_id: post)
    if like.save
      render json: {
          success: true,
          message: "Liked Success"
      }
    else
      render json: {
          success: false,
          message: "Error Occured"
      }
    end
  end

  def destroy
    like = Like.find_by(id: params[:id])
    if like.destroy
      render json: {
          success: true,
          message: "UnLiked Success"
      }
    else
      render json: {
          success: false,
          message: "Error Occured"
      }
    end
  end

  private

  def check_liked
    post = Post.find_by(id: params[:post_id])
    if Like.where(post_id: post,user_id: current_user).present?
      render json: {
          message: "You Already Liked"
      }
    end
  end

  def already_liked
    user = Like.find_by(id: params[:id]).user
    if user != current_user
      render json: {
          message: "UnAuthorization"
      }
    else
      post = Post.find_by(id: params[:post_id])
      unless Like.where(post_id: post,user_id: current_user).present?
        render json: {
            message: "You Not Liked"
        }
      end
    end
  end

end
