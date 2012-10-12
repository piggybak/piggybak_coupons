module PiggybakCoupons
  class Coupon < ActiveRecord::Base
    set_table_name 'coupons'

    validates_presence_of :code, :amount, :type, :min_cart_total

    attr_accessible :code, :amount, :type, :min_cart_total
  end
end
