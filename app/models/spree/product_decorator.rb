Spree::Product.class_eval do
  scope :gift_cards, -> { where(gift_card: true) }
end