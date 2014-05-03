class Circle < ActiveRecord::Base
  after_create :set_values

  #0202B3
  #A20000


  def set_values
    update_attributes! label: "Guest_#{token}", state: "#{get_state }"
  end

  def get_state
    ['hunter', 'prey'].sample()
  end

end