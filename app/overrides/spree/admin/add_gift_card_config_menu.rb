Deface::Override.new(
  :virtual_path => "spree/admin/shared/_configuration_menu",
  :name => "gift_cards_admin_configurations_menu",
  :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
  :text => "<%= configurations_sidebar_menu_item Spree.t(:gift_cards), admin_gift_cards_url %>",
  :disabled => false)