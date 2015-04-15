Deface::Override.new(
  virtual_path: 'spree/users/show',
  name: 'add_gift_cards_to_account_my_orders',
  insert_after: "[data-hook='account_my_orders']",
  partial: 'spree/users/gift_cards'
)