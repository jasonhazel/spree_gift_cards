Spree::UsersController.class_eval do 
  def redeem
    @gift_card = Spree::GiftCard.find_by(code: params[:code])
    
    if @gift_card.nil?
      redirect_to account_path, error: "Invalid Gift Card Code" and return
    end
    
    if @gift_card.user == current_user || @gift_card.used?
      redirect_to account_path, error: "Gift Card already redeemed." and return
    end

    # if @gift_card.nil?
    #   redirect_to account_path, error: "Invalid Gift Card Code."
    # else
    #   spree_current_user.store_credits << Spree::StoreCredit.create({
    #     amount: @gift_card.amount,
    #     remaining_amount: @gift_card.amount,
    #     reason: "Gift Card"
    #   })

    #   @gift_card.update_attributes({ active: false })

    #   redirect_to account_path, notice: 'Gift Card balance credited to account.'
    # end
  end
end