class AdduserIdToArc < ActiveRecord::Migration[5.2]
  def change
    add_column :arcs, :user_id, :integer
  end
end
