Spree::Core::Engine.routes.append do  
  namespace :admin do
    resources :gift_cards do 
      collection do 
        get :active, to: "gift_cards#active" 
        get :products
      end
      member do
        post :approve
      end
    end
  end

  post "account/redeem", to: "users#redeem"
  get "account/redeem/:code", to: "users#redeem"
  get "account/gift_card/:id/transfer", to: "users#transfer_gift_card", as: :account_transfer
  post "account/send", to: "users#send_gift_card"
end
