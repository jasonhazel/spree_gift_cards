Spree::Core::Engine.routes.append do  
  namespace :admin do
    resources :gift_cards
  end
end
