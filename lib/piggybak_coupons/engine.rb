require 'piggybak_coupons/line_item_decorator'

module PiggybakCoupons
  class Engine < ::Rails::Engine
    isolate_namespace PiggybakCoupons

    config.to_prepare do
      Piggybak::LineItem.send(:include, ::PiggybakCoupons::LineItemDecorator)
    end

    config.before_initialize do
      Piggybak.config do |config|
        config.line_item_types[:coupon_application] = { :visible => true,
                                                        :nested_attrs => true,
                                                        :fields => ["coupon_application"],
                                                        :allow_destroy => true,
                                                        :class_name => "::PiggybakCoupons::CouponApplication"
                                                      } 
      end
    end

    initializer "piggybak_coupons.rails_admin_config" do |app|
      RailsAdmin.config do |config|
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
