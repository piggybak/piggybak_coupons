PiggybakCoupons Gem (Engine)
========

Coupon support for Piggybak. Includes types %, $, and freeshipping. Coupons have a specified amount (tied to % and $ use), a minimum cart total, expiration date, and number of uses.

CanCan access must be updated to allow admin access to view coupons.

Install
========

In your Gemfile add `gem "piggybak_coupons"`

Run `bundle install`

Run `rake piggybak_coupons:install:migrations` in your main Rails application.
Migrate the DB `rake db:migrate`

Add //= require piggybak_coupons/piggybak_coupons-application to your application.js

In the admin, create coupons.

Finally, add `<%= render "piggybak_coupons/apply_coupon" %>` to your checkout view to render the input. 

TODO
========

* Modify JS to not require addition of "inputs", complete via backend filter instead.


Copyright
========

Copyright (c) 2014 End Point & Steph Skardal. See LICENSE for further details.
