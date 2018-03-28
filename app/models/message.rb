class Message < ApplicationRecord
  belongs_to :conversation, required: false
  belongs_to :user, required: false
  validates :content, presence: true

  scope :for_display, -> { order(:created_at).last(Settings.message.for_display) }

  def is_message? current_user
    return self.user == current_user
  end
end
