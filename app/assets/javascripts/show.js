$(document).ready(function(){
	$('#show-apply-now-btn').click(function(){
		$('#show-apply-now-div').toggleClass("apply-now-active");
		$(this).hide();
	});

	$('#show-apply-now-btn-2').click(function(){
		$('#show-apply-now-div-2').toggleClass("apply-now-active");
		$(this).hide();
	});

	$('.company-edit--options').click(function(){
		$('.company-edit--options').removeClass("company-edit--options-active");
		$(this).addClass("company-edit--options-active");
		var editID = this.id;
		$('.company-edit--section').hide();
		$('#company-edit-' + editID).show();
	});

	$('.post-view-count').click(function(){
		console.log(this.id);
	});

	$('.subscription-button').click(function(){
		$('.subscription-container').addClass('payment-active');
		$('.payment-options').addClass('payment-options-hidden');
		$('.payment-amount-disabled').attr('disabled', true);
		var paymentOption = this.id;
		$('#sub-btn-' + paymentOption).removeClass('payment-options-hidden');
		$('#mon-' + paymentOption).attr('disabled', false);
		$('#amt-' + paymentOption).attr('disabled', false);
	});

	// $('form > input:hidden').attr("disabled",true);
    
});

//Added 'Page:Load' because Turbolinks screws up JS when using link_to
$(document).on('page:load',function(){
	$('#show-apply-now-btn').click(function(){
		$('#show-apply-now-div').toggleClass("apply-now-active");
		$(this).hide();
	});

	$('#show-apply-now-btn-2').click(function(){
		$('#show-apply-now-div-2').toggleClass("apply-now-active");
		$(this).hide();
	});

	$('.company-edit--options').click(function(){
		$('.company-edit--options').removeClass("company-edit--options-active");
		$(this).addClass("company-edit--options-active");
		var editID = this.id;
		$('.company-edit--section').hide();
		$('#company-edit-' + editID).show();
	});
});