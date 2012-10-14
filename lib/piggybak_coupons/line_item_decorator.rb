module PiggybakCoupons
  module LineItemDecorator
    extend ActiveSupport::Concern

    def preprocess_coupon_application
      Rails.logger.warn "stephie here preprocessing coupon."
      #ensure validity of coupon here
      # Add error on code if not valid
    end 
  end
end
