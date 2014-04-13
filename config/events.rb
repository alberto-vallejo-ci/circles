WebsocketRails::EventMap.describe do
  namespace :circles do
    subscribe :index, :to => CirclesController, :with_method => :index
    subscribe :create, :to => CirclesController, :with_method => :create
    subscribe :destroy, :to => CirclesController, :with_method => :destroy
    subscribe :move, :to => CirclesController, :with_method => :move
    subscribe :update, :to => CirclesController, :with_method => :update
  end
end