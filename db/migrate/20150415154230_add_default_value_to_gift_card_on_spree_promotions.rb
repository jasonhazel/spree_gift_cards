class AddDefaultValueToGiftCardOnSpreePromotions < ActiveRecord::Migration
  def change
    change_column :spree_promotions, :gift_card, :boolean, :default => false
  end
end
