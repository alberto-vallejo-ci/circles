class CirclesController < WebsocketRails::BaseController
  before_filter :find_circle, only: [:update, :move]

  def index
    circles = Circle.all
    send_message :index, circles, namespace: :circles
  end

  def create
    circle = Circle.create token: message
    broadcast_message :create, circle, namespace: :circles
  end

  def update
    @circle.update_attributes! label: message[:label]
    broadcast_message :update, @circle, namespace: :circles
  end

  def destroy
    Circle.find_by_token(message).destroy
    broadcast_message :destroy, message, namespace: :circles
  end

  def move
    @circle.update_attributes!(pos_x: message[:pos_x], pos_y: message[:pos_y])
    broadcast_message :move, message, namespace: :circles
  end

  private

  def find_circle
    @circle = Circle.find_by_token message[:token]
  end
end