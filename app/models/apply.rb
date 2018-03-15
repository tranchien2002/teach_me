class Apply < ApplicationRecord
  belongs_to :user
  belongs_to :request
  validate :own_request
  validates_uniqueness_of :request_id, scope: :user_id

  private
  def own_request
    errors.add(:base, I18n.t("controllers.applies.create.error.owner")) if request.is_user?self.user_id
  end
end
