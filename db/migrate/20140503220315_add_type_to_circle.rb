class AddTypeToCircle < ActiveRecord::Migration
  def change
    add_column :circles, :state, :string
  end
end
