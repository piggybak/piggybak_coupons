require 'piggybak_coupons/line_item_decorator'

module PiggybakCoupons
  class Engine < ::Rails::Engine
    isolate_namespace PiggybakCoupons

    config.to_prepare do
      Piggybak::LineItem.send(:include, ::PiggybakCoupons::LineItemDecorator)
    end

    initializer "piggybak_coupons.line_item_types" do |app|
      Piggybak.config do |config|
        config.line_item_types[:coupon_application] = { :visible => true, :nested_attrs => true, :fields => ["coupon_application"], :allow_destroy => true } 
      end

      RailsAdmin.config do |config|
        config.model Piggybak::LineItem do
          edit do
            field :coupon_application do
              active true
            end
          end
        end
        config.model PiggybakCoupons::CouponApplication do
          label "Coupon"
          visible false

          edit do
            field :code
          end
        end
      end
    end 
  end
end
