Spree::UsersController.class_eval do 
  def redeem
    @gift_card = Spree::GiftCard.find_by(code: params[:code])
    
    if @gift_card.nil?
      message = { error: "Invalid Gift Card Code" }
    elsif @gift_card.user == current_user || @gift_card.used?
      message = { error: "Gift Card already redeemed" }
    else
      @gift_card.update_attributes(user_id: current_user.id)
      message = { notice: "Gift Card Redeemed" }
    end

    redirect_to account_path, message
  end

  def transfer_gift_card
    @gift_card = Spree::GiftCard.find(params[:id])
  end


  def send_gift_card
    @gift_card = Spree::GiftCard.find(params[:id])
    if Spree::GiftCardMailer.send_gift_card(@gift_card, params[:recipient], current_user).deliver 
      redirect_to account_path, notice: "Gift Card sent!"
    else
      redirect_to account_transfer_path(@gift_card), error: "Error sending Gift Card."
    end
  end
end