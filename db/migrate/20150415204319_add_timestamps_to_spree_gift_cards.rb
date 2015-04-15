class AddTimestampsToSpreeGiftCards < ActiveRecord::Migration
  def change
    add_timestamps(:spree_gift_cards)
  end
end
