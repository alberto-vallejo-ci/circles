class Circle < ActiveRecord::Base
  after_create :set_color

  def set_color
    self.color = "##{rand(9)}#{rand(9)}#{rand(9)}"
  end
end