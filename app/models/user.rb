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
  has_secure_password
  has_one_attached :avatar




  def avatar_url
    if self.avatar.attached?
      self.avatar.attachment.service.send(:object_for,self.avatar.key).public_url
    else
      ""
    end
  end

end
