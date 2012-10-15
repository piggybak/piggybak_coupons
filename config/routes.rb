PiggybakCoupons::Engine.routes.draw do
  match "/apply_coupon" => "coupon#apply"
end
