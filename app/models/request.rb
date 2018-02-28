class Request < ApplicationRecord
  enum topic: {math: 0, it: 1, literary: 2, history: 3, chemistry:4, physics: 5, other: 6}
  enum status: {looking: 0, done: 1}
  has_many :applies, dependent: :destroy
  belongs_to :user
  validates :bill, presence: true, numericality: { only_float: true },format: {with: /[0-9]*\.[0-9]*/}
  validates :header, presence: true, length: {minimum: 10}
  validates :content, presence: true, length: {minimum: 20}
end
