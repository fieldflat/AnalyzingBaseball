module TeamsHelper
  def is_member?(user)
    members.include?(user)
  end
end
