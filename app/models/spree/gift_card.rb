module Spree
  class GiftCard < Spree::Base
    
    CODE_LENGTH = 6 # generated code's length will be twice this

    belongs_to :user 
    belongs_to :order

    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :with_balance, -> { where("remaining > 0") }
    scope :active_with_balance, -> { active.where('remaining > 0').order('remaining asc') }

    def used?
      remaining != amount
    end


    def consume(amount)
      self.remaining = self.remaining - amount
    end

    def can_consume?(amount)
      amount < self.amount
    end

    class << self
      def generate_code 
        code = SecureRandom.hex(CODE_LENGTH) 
        while (where(code: code).size != 0)
          code = SecureRandom.hex(CODE_LENGTH)
        end
        code
      end

      def balance(user)
        user.gift_cards.active.sum(:remaining)
      end
    end
  end
end