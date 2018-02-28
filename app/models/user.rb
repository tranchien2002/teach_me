class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :reviews, foreign_key: :user_id, dependent: :destroy
  has_many :experts, class_name: Conversation.name, foreign_key: :expert_id, dependent: :destroy
  has_many :newbies, class_name: Conversation.name, foreign_key: :newbie_id, dependent: :destroy
  has_many :messages, foreign_key: :user_id, dependent: :destroy
  has_many :applies, foreign_key: :user_id, dependent: :destroy
  has_many :payments, foreign_key: :user_id, dependent: :destroy
  has_many :diplomas, foreign_key: :user_id, dependent: :destroy
  has_many :requests, foreign_key: :user_id, dependent: :destroy
end
