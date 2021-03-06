(function( $, undefined ) {
	var pp = {
		elements: [],
		screenOffset: -($(window).height() / 2)
	}
	var elements = [];
	var bind = function() {
		$(window).on('scroll', function() {
			var scrollTop = $(window).scrollTop();
			$.each(pp.elements, function() {
				// if ( triggerOut > -100 && triggerOut < 300 ) {
				this.setOpacity();
				// }
			});
		});
		$(window).resize(function() {
			$.each(pp.elements, function() {
				this.init();
			});
		});
	};

	var setOpacity = function() {
		var scrollTop = $(window).scrollTop();
		var position = scrollTop - pp.screenOffset;
		var fadeInPoint = this.inTriggerPosition - position;
		var fadeOutPoint = this.outTriggerPosition - position;
		if ( (fadeInPoint !== null && fadeInPoint > 0) || (fadeOutPoint !== null && fadeOutPoint < 0)  ) {
			$(this.target).stop().hide();
		} else {
			if ( fadeInPoint < 0 ) {
				$(this.target).stop().show();
			} else {
				$(this.target).stop().hide();
			}
		}
	};

	var init = function() {
		this.outTriggerPosition = $(this.target.attr('data-trigger-out')).position().top;
		if ( this.target.attr('data-trigger-in') ) {
			// this.inTriggerPosition = $(this.target.parent()).position().top + 200;		
			this.inTriggerPosition = $(this.target.attr('data-trigger-in')).position().top + 200;
			// console.log("trigger position: " + this.inTriggerPosition);
			// var parentPos = $(this.target.parent()).position().top + 200;

			// console.log("parent: " + parentPos);
		}
	};

	var methods = {
		init: function( options ) {
			$.each(this, function(index) {
				var element = {
					init: init,
					inTriggerPosition: null,
					outTriggerPosition: null,
					setOpacity: setOpacity
				};
				element.target = $(this);
				element.init();
				pp.elements.push(element);
				element.setOpacity();
			});
			bind();
		}, 
		stop: function() {

		}
	};

  $.fn.powerpoint = function( option ) {
		if ( methods[option] ) {
      return methods[option].apply( this, Array.prototype.slice.call( arguments, 1 ));
    } else if ( typeof option === 'function' || !option ) {
			return methods.init.apply( this, arguments );
    } else {
      $.error( 'Method ' +  option + ' does not exist on jQuery.powerpoint' );
    }
  };

})(jQuery)