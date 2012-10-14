module PiggybakCoupons
  class Coupon < ActiveRecord::Base
    set_table_name 'coupons'

    validates_presence_of :code, :amount, :discount_type, :min_cart_total
    has_many :coupon_applications

    attr_accessible :code, :amount, :discount_type, :min_cart_total

    def self.valid_coupon(code, object)
      # First check
      coupon = Coupon.find_by_code(code)
      return false if coupon.nil?

      # Expiration date check
      return false if coupon.expiration_date < Date.today

      # Min cart total check
      # return false if object.subtotal < coupon.min_cart_total

      # Allowed applications check 
      # return false if coupon.allowed_applications >= coupon.coupon_applications

      coupon
    end
     
    def self.apply_discount(code, object)
      coupon = Coupon.find_by_code(code)
      return 0 if coupon.nil?
 
      # $ or % discount_type discount   
      if coupon.discount_type == "$"
        return -1*coupon.amount
      elsif coupon.discount_type == "%"
        return -1*(coupon.amount/100)*object.subtotal
      end 
    end   
  end
end
