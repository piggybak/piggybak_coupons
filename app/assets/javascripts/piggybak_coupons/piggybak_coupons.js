$(function() {
	if($('form#new_order').size() == 0) {
		return;
	}
	$('#coupon_code').change(function() {
		piggybak_coupons.apply_coupon();
	});
	$(piggybak.shipping_els).on('change', function() {
		if($('#coupon_code').val() != '') {
			setTimeout(function() {
				piggybak_coupons.apply_coupon();
			}, 500);
		}
	});
	$('#shipping select').on('change', function() {
		piggybak_coupons.apply_coupon();
	});
	setTimeout(function() {
		if($('#coupon_code').val() != '') {
			piggybak_coupons.apply_coupon();
		}
	}, 500);
});

var piggybak_coupons = {
	apply_coupon: function() {
		$('#coupon input[type=hidden]').remove();
		$('#coupon_response').hide();
		$('#coupon_ajax').show();
		$.ajax({
			url: coupon_lookup,
			cached: false,
			data: {
				code: $('#coupon_code').val(),
				shipcost: $('#shipping_total').html().replace(/^\$/, '')
			},
			dataType: "JSON",
			success: function(data) {
				if(data.valid_coupon) {
					var el1 = $('<input>').attr('type', 'hidden').attr('name', 'order[line_items_attributes][2][line_item_type]').val('coupon_application');
					var el2 = $('<input>').attr('type', 'hidden').attr('name', 'order[line_items_attributes][2][coupon_application_attributes][code]').val($('#coupon_code').val());
					$('#coupon').append(el1);
					$('#coupon').append(el2);
					$('#coupon_response').html('Coupon successfully applied to order.').show();
					$('#coupon_application_total').html('-$' + (-1*parseFloat(data.amount)).toFixed(2));
					$('#coupon_application_row').show();
					piggybak.update_tax();
					piggybak.update_totals();
				} else {
					if($('#coupon_code').val() != '') {
						$('#coupon_response').html(data.message).show();
					}
					$('#coupon_application_total').html('$0.00');
					$('#coupon_application_row').hide();
					piggybak.update_tax();
					piggybak.update_totals();
				}
				$('#coupon_ajax').hide();
			},
			error: function() {
				$('#coupon_ajax').hide();
			}
		});
	}	
};
