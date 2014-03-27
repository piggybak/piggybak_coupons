module PiggybakCoupons
  class CouponApplication < ActiveRecord::Base
    belongs_to :coupon
    belongs_to :line_item, :class_name => "::Piggybak::LineItem", :dependent => :destroy

    attr_accessor :code, :order

    validate :validate_coupon
    def validate_coupon
      if self.new_record?
        valid_coupon = Coupon.valid_coupon(self.code, self.order, false)
        if valid_coupon.is_a?(::PiggybakCoupons::Coupon)
          self.coupon_id = valid_coupon.id
        else
          self.errors.add(:code, valid_coupon)
        end
      end
    end
  end
end
