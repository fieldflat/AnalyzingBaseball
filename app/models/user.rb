class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :team_members, class_name: "TeamMember",
                                foreign_key: "member_id",
                                dependent: :destroy
  has_many :teams, through: :team_members, source: :team
  has_many :journals, dependent: :destroy

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def register(team)
    TeamMember.create(team_id: team.id, member_id: self.id)
  end

  def unregister(team)
    member_teams.find_by(team_id: team.id).destroy
  end

  def is_register?(team)
    teams.include?(team)
  end

end
