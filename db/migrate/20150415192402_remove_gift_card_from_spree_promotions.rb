class RemoveGiftCardFromSpreePromotions < ActiveRecord::Migration
  def change
    remove_column :spree_promotions, :gift_card
  end
end
