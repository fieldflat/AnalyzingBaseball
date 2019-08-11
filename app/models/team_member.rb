class TeamMember < ApplicationRecord
  belongs_to :team, class_name: "Team"
  belongs_to :member, class_name: "User"
  validates :team_id, presence: true
  validates :member_id, presence: true
end
