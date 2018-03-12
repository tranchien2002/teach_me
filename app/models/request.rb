class Request < ApplicationRecord
  enum topic: {Math: 0, IT: 1, Literary: 2, History: 3, Chemistry:4, Physics: 5, Other: 6}
  enum status: {No_recipients: 1, Applying: 2, Done: 3}
  has_many :applies, dependent: :destroy
  belongs_to :user
  validates :bill, presence: true, numericality: { only_float: true },format: {with: /[0-9]*\.[0-9]*/}
  validates :header, presence: true, length: {minimum: Settings.request.header.minimum}
  validates :content, presence: true, length: {minimum: Settings.request.content.minimum}

  scope :request_user, -> user_id { where user_id: user_id}
end
