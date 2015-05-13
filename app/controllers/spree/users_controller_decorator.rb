Spree::UsersController.class_eval do 
  def redeem
    @gift_card = Spree::GiftCard.find_by(code: params[:code])
    spree_current_user.store_credits << Spree::StoreCredit.create({
      amount: @gift_card.amount,
      remaining_amount: @gift_card.amount,
      reason: "Gift Card"
    })

    @gift_card.update_attributes({ active: false })

    redirect_to account_path, notice: 'Gift Card balance credited to account.'
  end
end