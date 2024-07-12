class User < ApplicationRecord
  validates :name, :email, :campaigns_list, presence: true
end
