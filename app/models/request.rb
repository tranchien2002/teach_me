class Request < ApplicationRecord
  has_many :applies, dependent: :destroy
  belongs_to :user
end
