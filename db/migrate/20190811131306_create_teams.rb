class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :team_id
      t.string :password_digest

      t.timestamps
    end
  end
end
