class AddExpiryToArcs < ActiveRecord::Migration[5.2]
  def change
    add_column :arcs, :expiry, :datetime
  end
end
