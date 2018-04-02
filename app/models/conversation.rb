class Conversation < ApplicationRecord
  after_create :update_request_status
  has_many :messages, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :expert, class_name: User.name
  belongs_to :newbie, class_name: User.name
  belongs_to :request

  validates_uniqueness_of :request_id, scope: [:expert_id, :newbie_id]
  validate :accept_self?
  validate :owner_request?
  validate :users_in_free?

  scope :current_conversation, -> user_id {select(:id).where(done: false).where("newbie_id = ? OR expert_id = ?", user_id, user_id).limit(1)}

  def update_request_status
    request.update_attributes! status: :Done
  end

  def newbie? user_id
    return true if newbie.id == user_id
    false
  end

  private
  def accept_self?
    errors.add(:base, I18n.t("controllers.requests.show.error.error_owner")) if expert_id == newbie_id
  end

  def owner_request?
    errors.add(:base, I18n.t("controllers.requests.show.error.error_owner")) if request.user_id != newbie.id
  end

  def users_in_free?
    errors.add(:base, I18n.t("controllers.requests.show.error.error_busy")) if !newbie.free || !expert.free
  end
end
