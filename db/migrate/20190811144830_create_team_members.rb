class CreateTeamMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :team_members do |t|
      t.integer :team_id
      t.integer :member_id

      t.timestamps
    end
  end
end
