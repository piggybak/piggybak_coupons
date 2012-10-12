module PiggybakCoupons
  class CouponApplication < ActiveRecord::Base
    # TODO: figure out how to avoid this
    set_table_name 'coupon_applications'

    validates_presence_of :line_item_id, :coupon_id

    belongs_to :line_item, :class_name => "::Piggybak::LineItem"

    attr_accessor :code
    attr_accessible :line_item_id, :coupon_id, :code
  end
end
