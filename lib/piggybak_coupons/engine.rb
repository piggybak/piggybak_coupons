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
                                                        :class_name => "::PiggybakCoupons::CouponApplication",
                                                        :display_in_cart => "Discount"
                                                      } 
      end
    end

    initializer "piggybak_coupons.precompile_hook" do |app|
      app.config.assets.precompile += ['piggybak_coupons/piggybak_coupons.js']
    end

    initializer "piggybak_coupons.rails_admin_config" do |app|
      RailsAdmin.config do |config|
        config.model PiggybakCoupons::CouponApplication do
          label "Coupon"
          visible false

          edit do
            field :code do
              read_only do
                !bindings[:object].new_record?
              end
              pretty_value do
                bindings[:object].coupon ? bindings[:object].coupon.code : ""
              end 
            end
          end
        end
      end
    end 
  end
end
