Spree::LineItem.class_eval do 
  def is_gift_card?
    product.gift_card?
  end

end