PiggybakCoupons::Engine.routes.draw do
  get "/apply_coupon" => "coupon#apply"
end
