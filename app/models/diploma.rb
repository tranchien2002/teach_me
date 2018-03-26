class Diploma < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :demonstrate, presence: true
  validates :certification, presence: true, length: {minimum: Settings.request.header.minimum}

  mount_uploader :demonstrate, PictureUploader
  scope :verify, ->(verify){where verify: verify}
end
