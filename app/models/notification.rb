class Notification < ApplicationRecord
  belongs_to :sender, class_name: User.name, optional: true
  belongs_to :receiver, class_name: User.name
end
