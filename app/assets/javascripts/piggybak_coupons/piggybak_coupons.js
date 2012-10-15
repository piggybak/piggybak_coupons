$(function() {
	$('#apply_coupon').click(function() {
		piggybak_coupons.apply_coupon();
		return false;		
	});
});

var piggybak_coupons = {
	apply_coupon: function() {
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
					var el1 = $('<input>').attr('name', 'piggybak_order[line_item_attributes][2][line_item_type]').val('coupon_application');
					var el2 = $('<input>').attr('name', 'piggybak_order[line_items_attributes][2][coupon_application_attributes][code]').val($('#coupon_code').val());
					$('#coupon').append(el1);
					$('#coupon').append(el2);
					$('#coupon_response').html('Coupon successfully applied to order.');
					$('#coupon_application_total').html('$' + parseFloat(data.amount).toFixed(2));
					$('#coupon_application_row').show();
					piggybak.update_totals();
				} else {
					$('#coupon_response').html(data.message).show();
					$('#coupon_application_total').html('$0.00');
					$('#coupon_application_row').hide();
					piggybak.update_totals();
				}
			},
			error: function() {
				alert("here error!!");
			}
		});
	}	
};
