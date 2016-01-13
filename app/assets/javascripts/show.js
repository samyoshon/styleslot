$(document).ready(function(){
	$('#show-apply-now-btn').click(function(){
		$('#show-apply-now-div').toggleClass("apply-now-active");
		$('#show-apply-now-btn').hide();
	});
});
//Added 'Page:Load' because Turbolinks screws up JS when using link_to
$(document).on('page:load',function(){
	$('#show-apply-now-btn').click(function(){
		$('#show-apply-now-div').toggleClass("apply-now-active");
		$('#show-apply-now-btn').hide();
	});
});