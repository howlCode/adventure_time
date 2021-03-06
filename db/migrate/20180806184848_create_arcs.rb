class CreateArcs < ActiveRecord::Migration[5.2]
  def change
    create_table :arcs do |t|
      t.references :story, foreign_key: true
      t.text :body, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
