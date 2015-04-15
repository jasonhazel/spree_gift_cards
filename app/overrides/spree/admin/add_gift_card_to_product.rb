Deface::Override.new(
  :virtual_path => "spree/admin/products/_form",
  :name => "admin_gift_card",
  :insert_after => '[data-hook="admin_product_form_right"]',
  :partial => "spree/admin/products/gift_card",
  :disabled => false
)