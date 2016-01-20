$(document).ready(function(){
	$('#show-apply-now-btn').click(function(){
		$('#show-apply-now-div').toggleClass("apply-now-active");
		$('#show-apply-now-btn').hide();
	});

	$('#show-apply-now-btn-2').click(function(){
		$('#show-apply-now-div-2').toggleClass("apply-now-active");
		$('#show-apply-now-btn-2').hide();
		console.log('hello');
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
	})
});

//Added 'Page:Load' because Turbolinks screws up JS when using link_to
$(document).on('page:load',function(){
	$('#show-apply-now-btn').click(function(){
		$('#show-apply-now-div').toggleClass("apply-now-active");
		$('#show-apply-now-btn').hide();
	});

	$('.company-edit--options').click(function(){
		$('.company-edit--options').removeClass("company-edit--options-active");
		$(this).addClass("company-edit--options-active");
		var editID = this.id;
		$('.company-edit--section').hide();
		$('#company-edit-' + editID).show();
	});
});