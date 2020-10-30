class Api::V1::RelationshipsController < ApplicationController
  before_action :authenticate_user

  def create
    user = User.find_by(id: params[:user_id])
    if user
      current_user.follow(user)
      render json: {
          success: true,
          message: "Follow Success"
      }
    else
      render json: {
          success: false,
          message: "No User"
      }
    end
  end

  def destroy
    relation = Relationship.find_by(id: params[:id])
    if relation
      relation.destroy
      render json: {
          success: true,
          message: "UnFollow Success"
      }
    else
      render json: {
          success: false,
          message: "You don't follow"
      }
    end
  end

end
