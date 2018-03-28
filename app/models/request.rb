class Request < ApplicationRecord
  enum topic: {Math: 0, IT: 1, Literary: 2, History: 3, Chemistry:4, Physics: 5, Other: 6}
  enum status: {Applying: 1, Done: 2}
  has_many :applies, dependent: :destroy
  has_many :appliers, -> { order free: :desc }, through: :applies, source: :user
  belongs_to :user
  has_one :conversation, dependent: :destroy
  validates :bill, presence: true, numericality: { only_float: true },format: {with: /[0-9]*\.[0-9]*/}
  validates :header, presence: true, length: {minimum: Settings.request.header.minimum}
  validates :content, presence: true, length: {minimum: Settings.request.content.minimum}

  scope :request_applying, -> {where(status: :Applying).order(created_at: :desc)}

  scope :hot_topic, -> {select(:topic).group(:topic).where(status: :Applying).limit(Settings.home.hot_topic_count)}

  scope :request_by_topic, -> topic {where(status: :Applying, topic: topic).order created_at: :desc}

  def is_user? other_id
    user_id == other_id
  end

  def is_done?
    return true if status == "Done"
    false
  end
end
