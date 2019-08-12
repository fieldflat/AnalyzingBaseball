class Journal < ApplicationRecord
  belongs_to :team
  belongs_to :user
  validates :user_id, presence: true
  validates :team_id, presence: true
  validates :content, presence: true, length: {minimum: 10}
end
