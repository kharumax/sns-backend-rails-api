class Post < ApplicationRecord

  # validates
  validates :user_id,presence: true,null: false
  validates :context,presence: true,length: { minimum: 2,maximum: 255}
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: "must be a valid image format" },
            size:         { less_than: 5.megabytes,
                            message: "should be less than 5MB" }
  has_one_attached :image
  belongs_to :user
  has_many :likes
  has_many :comments

  def image_url
    if self.image.attached?
      self.image.attachment.service.send(:object_for,self.image.key).public_url
    else
      ""
    end
  end

end
