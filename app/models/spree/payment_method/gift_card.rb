
class Spree::PaymentMethod::GiftCard < Spree::PaymentMethod

  def payment_source_class
    Spree::GiftCard
  end

  def provider
    @provider ||= self
  end

  def actions
    %w{capture void}
  end

  def can_capture?(payment)
    ['checkout', 'pending'].include?(payment.state)
  end

  def can_void?(payment)
    payment.state != 'void'
  end

  def capture(amount, source = nil, options = {})
    customer = Spree::User.find(options[:customer_id])
    gift_cards = customer.gift_cards.active_with_balance

    amount = amount / 100.0

    if gift_cards.sum(:remaining) < amount 
      return ActiveMerchant::Billing::Response.new(false, "Gift Card balances are not enough to cover amount.", {}, {})
    end

    gift_cards.each do |gc|
      charged_amount = 0
      if gc.remaining < amount 
        amount = amount - gc.remaining
        charged_amount = gc.remaining
        gc.update_attributes(remaining: 0)
      else 
        charged_amount = amount
        gc.update_attributes(remaining: gc.remaining - amount)
        amount = 0
      end 
      

      if options[:order] != nil && charged_amount != 0
        gc_adjustment = Spree::Adjustment.create(
          source_id: gc.id,
          source_type: 'Spree::GiftCard',
          adjustable_id: options[:order].id,
          adjustable_type: 'Spree::Order',
          amount: -charged_amount,
          state: 'closed',
          order_id: options[:order].id,
          label: 'Gift Card'
        )
      end
        
      break if amount == 0
    end

    ActiveMerchant::Billing::Response.new(true, "", {}, {})
  end

  def purchase(amount, source, options = {})
    binding.pry
  end

  def authorize(amount, source, options = {})
    binding.pry
  end

  def cancel(response)
    binding.pry
  end

  def void(*args)
    ActiveMerchant::Billing::Response.new(true, "", {}, {})
  end

  def source_required?
    false
  end

  def supports?(source)
    true
  end

  def auto_capture?
    true
  end 

  def method_type
    'gift_card'
  end
end
