$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "piggybak_coupons/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "piggybak_coupons"
  s.version     = PiggybakCoupons::VERSION
  s.authors     = ["Steph Skardal"]
  s.email       = ["steph@endpoint.com"]
  s.homepage    = "http://www.piggybak.org/"
  s.summary     = "Coupon support for Piggybak."
  s.description = "Coupon support for Piggybak."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
end
