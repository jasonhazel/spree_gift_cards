class AddRemainingToSpreeGiftCards < ActiveRecord::Migration
  def change
    add_column :spree_gift_cards, :remaining, :decimal
  end
end
