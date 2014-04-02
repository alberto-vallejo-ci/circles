class CirclesController < WebsocketRails::BaseController
  def create
    send_message :create, message, namespace: :circles
  end
end