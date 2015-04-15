class AddActiveToSpreeGiftCards < ActiveRecord::Migration
  def change
    add_column :spree_gift_cards, :active, :boolean
  end
end
