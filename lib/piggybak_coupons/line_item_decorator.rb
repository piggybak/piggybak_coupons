module PiggybakCoupons
  module LineItemDecorator
    extend ActiveSupport::Concern

    included do
      has_one :coupon_application, :class_name => "::PiggybakCoupons::CouponApplication"

      attr_accessible :coupon_application_attributes
      
      accepts_nested_attributes_for :coupon_application
    end

    def preprocess_coupon_application
      Rails.logger.warn "stephie here preprocessing coupon."
      #ensure validity of coupon here
      # Add error on code if not valid
    end 
  end
end
