class Circle < ActiveRecord::Base
  after_create :set_values

  def set_values
    update_attributes! color: "##{rand(9)}#{rand(9)}#{rand(9)}", label: "Guest_#{token}"
  end
end