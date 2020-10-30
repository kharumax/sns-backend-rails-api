class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    post = Post.find_by(id: params[:post_id])
    comment = Comment.new(user_id: current_user,post_id: post)
    if comment.save
      json_comment = CommentSerializer.new(comment).serialized_json
      render json_comment
    else
      render json: {
          success: false,
          message: "Error Occured"
      }
    end
  end

end
