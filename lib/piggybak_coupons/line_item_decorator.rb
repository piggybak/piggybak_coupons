module PiggybakCoupons
  module LineItemDecorator
    extend ActiveSupport::Concern

    def preprocess_coupon_application
      self.description = "Coupon"
      if self.new_record?
        coupon = Coupon.valid_coupon(self.coupon_application.code, self.order)
        if coupon
          self.price = Coupon.apply_discount(coupon.code, self.order)
          self.coupon_application.coupon_id = coupon.id
        end
      else
        coupon = Coupon.valid_coupon(self.coupon_application.coupon.code, self.order)
        if coupon
          self.price = Coupon.apply_discount(self.coupon_application.coupon.code, self.order)
        else
          # TODO: Mark to destroy
        end
      end
    end 
  end
end
