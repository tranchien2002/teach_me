class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  has_many :reviews, foreign_key: :user_id, dependent: :destroy
  has_many :experts, class_name: Conversation.name, foreign_key: :expert_id, dependent: :destroy
  has_many :newbies, class_name: Conversation.name, foreign_key: :newbie_id, dependent: :destroy
  has_many :messages, foreign_key: :user_id, dependent: :destroy
  has_many :applies, foreign_key: :user_id, dependent: :destroy
  has_many :appling, through: :applies, source: :request
  has_many :payments, foreign_key: :user_id, dependent: :destroy
  has_many :diplomas, foreign_key: :user_id, dependent: :destroy
  has_many :requests, foreign_key: :user_id, dependent: :destroy

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
