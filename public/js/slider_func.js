    $(window).load(function(){
      $('.flexslider').flexslider({
        animation: "fade",
       
        start: function(){},            //Callback: function(slider) - Fires when the slider loads the first slide
		before: function(){captionMoveOut();},           //Callback: function(slider) - Fires asynchronously with each slider animation
		after: function(){captionMoveIn();},            //Callback: function(slider) - Fires after each slider animation completes
		end: function(){},              //Callback: function(slider) - Fires when the slider reaches the last slide (asynchronous)
		added: function(){},            //{NEW} Callback: function(slider) - Fires after a slide is added
		removed: function(){} 
      });
      
      $('.flex-caption').hide();
      
       $('.flex-caption').fadeIn(2000);
    });
    
    function captionMoveIn() {
		$('.flex-caption')
		.animate({top: "35%"},0)
		.fadeIn(2000)
	;};
	
	
	function captionMoveOut() {
		$('.flex-caption')
		.animate({top: "-40%"},700)
		.fadeOut("normal")
		
	;};