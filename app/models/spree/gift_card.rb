module Spree
  class GiftCard < Spree::Base
    
    CODE_LENGTH = 6 # generated code's length will be twice this

    belongs_to :user 
    belongs_to :order

    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }

    class << self
      def generate_code 
        code = SecureRandom.hex(CODE_LENGTH) 
        while (where(code: code).size != 0)
          code = SecureRandom.hex(CODE_LENGTH)
        end
        code
      end
    end

  end
end