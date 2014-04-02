WebsocketRails::EventMap.describe do
  namespace :circles do
    subscribe :create, :to => CirclesController, :with_method => :create
  end
end