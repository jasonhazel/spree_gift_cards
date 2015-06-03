class ChangeRemainingFieldOnSpreeGiftCards < ActiveRecord::Migration
  def change
    change_column :spree_gift_cards, :remaining, :decimal, precision: 10, scale: 2
  end
end
