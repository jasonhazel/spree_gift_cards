module Spree
  class Admin::GiftCardsController < Admin::BaseController
    def index
      @gift_cards = Spree::Product.gift_cards 
      @active_cards = Spree::GiftCard.active
      @inactive_cards = Spree::GiftCard.inactive
    end

    def show
    end

    def new
    end

    def create
    end

    def update
    end

    def destroy
    end

    private
      def permitted_params
        # params.permit(:gift_cards)
      end
  end
end