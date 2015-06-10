Spree::Order.class_eval do 
  state_machine.before_transition to: :complete, do: :process_payment

  register_update_hook :create_gift_cards

  has_many :gift_cards

  def process_payment
    gc_payment = payments.where(payment_method_id: Spree::PaymentMethod.find_by(name: 'Gift Card')).where(state: 'checkout')
    unless gc_payment.empty?
      gc_balance = user.gift_cards.active_with_balance.sum(:remaining)
      gc_payment.first.update_attributes(amount: [gc_payment.first.amount, gc_balance].min)
      gc_payment.first.payment_method.capture(gc_payment.first.amount * 100, nil, { customer_id: user.id, order: self })
      # create line item
      self.update!
      return self.total == 0
    end

    true
  end


  def create_gift_cards 
    if gift_cards.empty? && paid?
      gift_card_line_items.each do |gc|
        gc.quantity.times do
          user.gift_cards << Spree::GiftCard.new({
            code: Spree::GiftCard.generate_code,
            amount: gc.price,
            active: false,
            order: self,
            remaining: gc.price
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