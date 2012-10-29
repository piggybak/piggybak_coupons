$(function() {
	$('#coupon_code').change(function() {
		$(this).data('changed', true);
	});
	piggybak.shipping_els.live('change', function() {
		if($('#coupon_code').val() != '') {
			setTimeout(function() {
				$('#coupon_code').data('changed', true);
				piggybak_coupons.apply_coupon(false);
			}, 500);
		}
	});
	$('#shipping select').live('change', function() {
		$('#coupon_code').data('changed', true);
		piggybak_coupons.apply_coupon(false);
	});
	$('#apply_coupon').click(function() {
		piggybak_coupons.apply_coupon(false);
		return false;		
	});
	$('#submit input').click(function() {
		piggybak_coupons.apply_coupon(true);
		return false;
	});
	setTimeout(function() {
		if($('#coupon_code').val() != '') {
			$('#coupon_code').data('changed', true);
			piggybak_coupons.apply_coupon(false);
		}
	}, 500);
});

var piggybak_coupons = {
	apply_coupon: function(on_submit) {
		if(!$('#coupon_code').data('changed')) {
			if(on_submit) {
				$('#new_piggybak_order').submit();
			}
			return;
		}
		$('#coupon_code').data('changed', false);
		$('#coupon input[type=hidden]').remove();
		$('#coupon_response').hide();
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
					var el1 = $('<input>').attr('type', 'hidden').attr('name', 'piggybak_order[line_items_attributes][2][line_item_type]').val('coupon_application');
					var el2 = $('<input>').attr('type', 'hidden').attr('name', 'piggybak_order[line_items_attributes][2][coupon_application_attributes][code]').val($('#coupon_code').val());
					$('#coupon').append(el1);
					$('#coupon').append(el2);
					$('#coupon_response').html('Coupon successfully applied to order.');
					$('#coupon_application_total').html('-$' + (-1*parseFloat(data.amount)).toFixed(2));
					$('#coupon_application_row').show();
					piggybak.update_totals();
				} else {
					$('#coupon_response').html(data.message).show();
					$('#coupon_application_total').html('$0.00');
					$('#coupon_application_row').hide();
					piggybak.update_totals();
				}
				if(on_submit) {
					$('#new_piggybak_order').submit();
				}
			},
			error: function() {
				//do nothing right now
			}
		});
	}	
};
