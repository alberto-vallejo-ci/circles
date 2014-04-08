class CirclesController < WebsocketRails::BaseController
  def index
    circles = Circle.all
    send_message :index, circles, namespace: :circles
  end

  def create
    circle = Circle.create token: message
    broadcast_message :create, circle, namespace: :circles
  end

  def destroy
    Circle.find_by_token(message).destroy
    broadcast_message :destroy, message, namespace: :circles
  end

  def move
    circle = Circle.find_by_token(message[:token])
    circle.update_attributes!(pos_x: message[:pos_x], pos_y: message[:pos_y])

    broadcast_message :move, message, namespace: :circles
  end
end