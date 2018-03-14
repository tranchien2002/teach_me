class Apply < ApplicationRecord
  belongs_to :user
  belongs_to :request, optional: true
end
