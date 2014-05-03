class RemoveColorFromCircle < ActiveRecord::Migration
  def change
    remove_column :circles, :color
  end
end
