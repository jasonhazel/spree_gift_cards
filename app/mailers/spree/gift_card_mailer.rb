module Spree
  class GiftCardMailer < BaseMailer
    def send_gift_card(gift_card, recipient, from)
      subject = "#{from.email} sent you a gift card!"
      
      @gift_card = gift_card 
      @from = from

      mail(to: recipient, from: 'readymaderc@readymaderc.com', subject: subject)
    end
  end
end