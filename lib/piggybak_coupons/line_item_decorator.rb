module PiggybakCoupons
  module LineItemDecorator
    extend ActiveSupport::Concern

    def preprocess_coupon_application
      self.description = "Coupon"
      self.coupon_application.order = self.order
      if !self.new_record?
        valid_coupon = ::PiggybakCoupons::Coupon.valid_coupon(self.coupon_application.coupon.code, self.order, true)
        if !valid_coupon.is_a?(::PiggybakCoupons::Coupon)
          self.mark_for_destruction
        end
      end
    end

    def postprocess_coupon_application
      self.price = ::PiggybakCoupons::Coupon.apply_discount(self.coupon_application.coupon.code, self.order)
      true
    end 
  end
end
