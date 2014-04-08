class CircleTable < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string :token
      t.string :label
      t.string :color
      t.string :pos_x
      t.string :pos_y
    end
  end
end
