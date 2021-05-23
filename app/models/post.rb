class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :picture
  default_scope { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, length: { maximum: 20 }
  validates :text, length: { maximum: 255 }
  validates :only_user_id, presence: true
  validate :validate_picture

  def resize_picture
    picture.variant(resize: '100x100').processed
  end

  def resize_picture_show
    picture.variant(resize: '300x300').processed
  end

  def complete_task
    update_attribute(:complete, true)
  end

  def completed
    scope :completed, -> {　where(complete: false) }
  end

  private

  def only_user_id
    content.presence || text.presence
  end

  def validate_picture
    if picture.attached?
      if !picture.blob.content_type.in?(%('image/jpeg image/jpg image/png image/gif'))
        errors.add(:picture, 'はjpeg, jpg, png, gif以外の投稿ができません')
      elsif picture.blob.byte_size > 5.megabytes
        errors.add(:picture, 'のサイズが5MBを超えています')
      end
    end
  end
end
