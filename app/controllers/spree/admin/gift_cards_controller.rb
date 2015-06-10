module Spree
  class Admin::GiftCardsController < Admin::BaseController
    before_action :collect_users, only: [ :new ]


    def index


      @inactive_cards = Spree::GiftCard.inactive
    end

    def show
    end

    def new
      @gift_card = Spree::GiftCard.new 
    end

    def create
      @gift_card = Spree::GiftCard.new(permitted_params.merge(default_attributes))
      if @gift_card.save
        redirect_to admin_gift_cards_path
      else
        render :edit 
      end
    end

    def active
      @active_cards = Spree::GiftCard.active
    end

    def products
      @gift_cards = Spree::Product.gift_cards 
    end

    def approve 
      @gift_card = Spree::GiftCard.find(params[:id])
      if @gift_card.update_attributes(active: true)
        redirect_to admin_gift_cards_path, notice: "Gift Card Approved"
      else
        redirect_to admin_gift_cards_path, error: "Error approving Gift Card"
      end
    end

    private
      def permitted_params
        params.require(:gift_card).permit(:user_id, :amount, :active)
      end

      def default_attributes
        { active: true, code: Spree::GiftCard.generate_code } 
      end

      def collect_users 
        user_ids = Spree::Order.select(:user_id).uniq.map(&:user_id)
        @users = Spree::User.where(id: user_ids)
        @users = @users.collect{ |p| [p.email, p.id] }  
      end
  end
end