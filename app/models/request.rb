class Request < ApplicationRecord
  enum topic: {Math: 0, IT: 1, Literary: 2, History: 3, Chemistry:4, Physics: 5, Other: 6}
  enum status: {No_recipients: 1, Applying: 2, Done: 3}
  has_many :applies, dependent: :destroy
  has_many :appliers, through: :applies, source: :user
  belongs_to :user
  has_one :conversation, dependent: :destroy
  validates :bill, presence: true, numericality: { only_float: true },format: {with: /[0-9]*\.[0-9]*/}
  validates :header, presence: true, length: {minimum: Settings.request.header.minimum}
  validates :content, presence: true, length: {minimum: Settings.request.content.minimum}

  def is_user? other_id
    user_id == other_id
  end
end
