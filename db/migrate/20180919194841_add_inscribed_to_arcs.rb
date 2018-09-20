class AddInscribedToArcs < ActiveRecord::Migration[5.2]
  def change
    add_column :arcs, :inscribed, :boolean, default: false
  end
end
