class Team < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_TEAM_ID_REGEX = /\A[a-zA-Z0-9]+\z/
  validates :team_id, presence: true, length: { minimum: 8 },
                      format: { with: VALID_TEAM_ID_REGEX }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :member_teams, class_name: "TeamMember",
                                foreign_key: "team_id",
                                dependent: :destroy
  has_many :members, through: :member_teams, source: :member
  has_many :journals, dependent: :destroy

  # 渡された文字列のハッシュ値を返す
  def Team.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def is_member?(user)
    members.include?(user)
  end

end
