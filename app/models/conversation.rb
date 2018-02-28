class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :expert, class_name: User.name
  belongs_to :newbie, class_name: User.name
end
