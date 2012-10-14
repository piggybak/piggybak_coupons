module PiggybakCoupons
  class CouponApplication < ActiveRecord::Base
    # TODO: figure out how to avoid this
    set_table_name 'coupon_applications'

    #validates_presence_of :coupon_id
    belongs_to :coupon

    belongs_to :line_item, :class_name => "::Piggybak::LineItem"

    attr_accessor :code
    attr_accessible :line_item_id, :coupon_id, :code

    validate :add_error
    def add_error
      self.errors.add(:code, "Invalid coupon code") if self.coupon.nil? 
    end
  end
end
