class AddGiftCardToPromotions < ActiveRecord::Migration
  def change
    add_column :spree_promotions, :gift_card, :boolean
  end
end
