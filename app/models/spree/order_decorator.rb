Spree::Order.class_eval do 
  # state_machine.before_transition to: :complete, do: :create_gift_cards 

  register_update_hook :create_gift_cards

  has_many :gift_cards

  def create_gift_cards 
    if gift_cards.empty? && paid?
      gift_card_line_items.each do |gc|
        gc.quantity.times do
          user.gift_cards << Spree::GiftCard.new({
            code: Spree::GiftCard.generate_code,
            amount: gc.price,
            active: true,
            order: self
          })
        end
      end
    end
  end

  def gift_card_line_items 
    line_items.select(&:is_gift_card?)
  end

  def purchased_gift_cards?
    (products & Spree::Product.gift_cards).size > 0
  end
end