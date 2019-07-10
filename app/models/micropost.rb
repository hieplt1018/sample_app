class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: Settings.content_post }
  validate  :picture_size

  delegate :name, to: :user, prefix: true

  scope :published, -> { order created_at: desc}
  mount_uploader :picture, PictureUploader

  private
    def picture_size
      return unless picture.size > Settings.image_size.megabytes
      errors.add(:picture, t("text.image_size"))
    end
end
