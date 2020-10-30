class User < ApplicationRecord

  # validates
  validates :name,presence: true,length: {minimum: 2,maximum: 20}
  validates :email,presence: true,uniqueness: true
  validates :introduction,length: {maximum: 255}
  validates :password,presence: true,length: {minimum: 6},allow_nil: true
  validates :avatar,content_type: { in: %w[image/jpeg image/gif image/png],
                                     message: "must be a valid image format" },
            size:         { less_than: 5.megabytes,
                            message: "should be less than 5MB" }
  has_many :posts,dependent: :destroy
  has_many :likes,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :active_relationships,class_name: "Relationship",
           foreign_key: "follower_id",dependent: :destroy
  has_many :passive_relationships,class_name: "Relationship",
           foreign_key: "followed_id",dependent: :destroy
  has_many :following,through: :active_relationships,source: :followed
  has_many :followers,through: :passive_relationships,source: :follower

  has_secure_password
  has_one_attached :avatar

  def avatar_url
    if self.avatar.attached?
      self.avatar.attachment.service.send(:object_for,self.avatar.key).public_url
    else
      ""
    end
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def get_posts
    if Post.where(user_id: self).present?
      Post.where(user_id: self).order(created_at: :desc)
    else
      nil
    end
  end

  def get_liked_posts
    if Like.where(user_id: self).present?
      Like.where(user_id: self).posts.order(created_at: :desc)
    else
      nil
    end
  end

end
