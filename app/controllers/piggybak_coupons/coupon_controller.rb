module PiggybakCoupons
  class CouponController < ApplicationController
    def apply
      cart = Piggybak::Cart.new(request.cookies["cart"])
      valid_coupon = ::PiggybakCoupons::Coupon.valid_coupon(params[:code], cart, true)
      if valid_coupon.is_a?(::PiggybakCoupons::Coupon)
        amount = ::PiggybakCoupons::Coupon.apply_discount(params[:code], cart, params[:shipcost])
        render :json => { :valid_coupon => true, :amount => amount }
      else
        render :json => { :valid_coupon => false, :message => valid_coupon }
      end
    end
  end
end
