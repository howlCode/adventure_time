class AddVoteIdToArc < ActiveRecord::Migration[5.2]
  def change
    add_column :arcs, :vote_id, :integer
  end
end
