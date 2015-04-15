class CreateSpreeGiftCards < ActiveRecord::Migration
  def change
    create_table :spree_gift_cards do |t|
      t.string :code
      t.decimal :amount
    end
  end
end
