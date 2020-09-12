class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user,only: [:create,:update,:destroy]
  before_action :correct_user,only: [:update,:destroy]

  def index
    posts = Post.all
    json_posts = PostSerializer.new(posts).serialized_json
    render json: json_posts
  end

  def show
    post = Post.find_by(id: params[:id])
    json_post = PostSerializer.new(post).serialized_json
    render json: json_post
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      json_post = PostSerializer.new(post).serialized_json
      render json: json_post
    else
      render json: {
          message: "ERROR OCCURED"
      }
    end
  end

  def update
    post = Post.find_by(id: params[:id])
    if post.update_attributes(post_params)
      json_post = PostSerializer.new(post).serialized_json
      render json: json_post
    else
      render json: {
          message: "ERROR OCCURED"
      }
    end
  end

  def destroy
    post = Post.find_by(id: params[:id])
    if post.destroy
      render json: {
          message: "Post deleted Success"
      }
    else
      render json: {
          message: "ERROR OCCURED"
      }
    end

  end

  private

  def post_params
    params.permit(:context,:image)
  end

  def correct_user
    user = Post.find_by(id: params[:id]).user
    if user != current_user
      render json: {
          message: "UnAuthorization"
      }
    end
  end


end
