class CirclesController < WebsocketRails::BaseController
  def create
    value = rand(100)
    broadcast_message :create, value, namespace: :circles
  end
end