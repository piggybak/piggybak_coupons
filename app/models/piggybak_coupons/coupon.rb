module PiggybakCoupons
  class Coupon < ActiveRecord::Base
    self.table_name = 'coupons'

    validates_presence_of :code, :amount, :discount_type, :min_cart_total
    has_many :coupon_applications

    attr_accessible :code, :amount, :discount_type, :min_cart_total

    def self.valid_coupon(code, object, already_applied)
      # First check
      coupon = Coupon.find_by_code(code)
      return "Invalid coupon code." if coupon.nil?

      # Expiration date check
      return "Expired coupon." if coupon.expiration_date < Date.today

      # Min cart total check
      return "Order does not meet minimum total for coupon." if object.subtotal < coupon.min_cart_total.to_f

      # Allowed applications check 
      return "Coupon has already been used #{coupon.allowed_applications} times." if !already_applied && (coupon.coupon_applications.size >= coupon.allowed_applications)

      if object.is_a?(Piggybak::Order) && coupon.discount_type == "ship"
        ship_line_item = object.line_items.detect { |li| li.line_item_type == "shipment" }
        return "No shipping on this order." if !ship_line_item
      end

      coupon
    end
     
    def self.apply_discount(code, object, shipcost = 0.0)
      coupon = Coupon.find_by_code(code)
      return 0 if coupon.nil?
 
      # $ or % discount_type discount   
      if coupon.discount_type == "$"
        return -1*coupon.amount
      elsif coupon.discount_type == "%"
        return -1*(coupon.amount/100)*object.subtotal
      elsif coupon.discount_type == "ship"
        if object.is_a?(Piggybak::Order)
          ship_line_item = object.line_items.detect { |li| li.line_item_type == "shipment" }
          if ship_line_item
            return -1*ship_line_item.price
          else
            return 0.00
          end
        elsif object.is_a?(Piggybak::Cart)
          return -1*shipcost.to_f
        end
      end
    end   
  end
end
