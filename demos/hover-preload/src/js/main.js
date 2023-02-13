
// Import core modules.
import { Application } from "@hotwired/stimulus";
import { Controller } from "@hotwired/stimulus";
import * as Turbo from "@hotwired/turbo";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

var turboEvents = [
	// "turbo:click",
	// "turbo:before-visit",
	// "turbo:visit",
	// "turbo:submit-start",
	// "turbo:before-fetch-request",
	// "turbo:before-fetch-response",
	// "turbo:submit-end",
	// "turbo:before-cache",
	// "turbo:before-render",
	// "turbo:before-stream-render",
	// "turbo:render",
	// "turbo:load",
	// "turbo:before-frame-render",
	// "turbo:frame-render",
	// "turbo:frame-load",
	// "turbo:frame-missing",
	// "turbo:fetch-request-error"
];

for ( var eventType of turboEvents ) {

	document.documentElement.addEventListener(
		eventType,
		( event ) => {

			console.group( "Event:", event.type );
			console.log( event.detail );
			console.groupEnd();

		}
	);

}

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

class HoverPreloadController extends Controller {

	// Every link target contained within the controller's scope will be preloaded when
	// the hover timer has completed.
	static targets = [ "link" ];
	// The hover threshold (ie, duration the user has to hover before the link preloading
	// kicks-in) can be configured.
	static values = {
		delay: {
			type: Number,
			default: 300
		}
	};

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I run once when the controller has been instantiated, but before it has been
	* connected to the host DOM element. A single instantiated controller may be connected
	* to the host element multiples times during the life-time of a page.
	*/
	initialize() {

		this.hoverTimer = 0;

	}


	/**
	* I run once after the component instance has been bound to the host DOM element. At
	* this point, all of the classes, targets, and values have already been bound.
	*/
	connect() {

		if ( this.hasLinkTarget ) {

			this.setupEvents();

		}

	}


	/**
	* I get called once after the component instance has been unbound from the host DOM
	* element. At this point, all of the targets have already been disconnected as well.
	*/
	disconnect() {

		this.teardownEvents();

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I handle the mouseenter event on the host element.
	*/
	handleMouseenter = ( event ) => {

		this.hoverTimer = window.setTimeout( this.handleTimeout, this.delayValue );

	};


	/**
	* I handle the mouseleave event on the host element.
	*/
	handleMouseleave = ( event ) => {

		window.clearTimeout( this.hoverTimer );
		this.hoverTimer = 0;

	};


	/**
	* I handle the timeout event triggered from the hover interactions.
	*/
	handleTimeout = () => {

		this.teardownEvents();
		this.preloadLinks();

	};


	/**
	* I ask the Turbo session to preload all of the link targets embedded within this
	* controller.
	*/
	preloadLinks() {

		for ( var target of this.linkTargets ) {

			console.log( "Preloading links for:", target.href.split( "/" ).at( -1 ) );
			// CAUTION: The "preloader" is an UNDOCUMENTED PROPERTY of the session (at
			// least as far as I can tell) - I only found it by looking at the source code
			// for the Turbo project. As such, use this technique at your own risk!
			Turbo.session.preloader.preloadURL( target );

		}

	}


	/**
	* I setup the hover events on the host element.
	*/
	setupEvents() {

		this.element.addEventListener( "mouseenter", this.handleMouseenter );
		this.element.addEventListener( "mouseleave", this.handleMouseleave );

	}


	/**
	* I teardown the hover events on the host element. Any pending timer will be cleared.
	*/
	teardownEvents() {

		window.clearTimeout( this.hoverTimer );
		this.hoverTimer = 0;

		this.element.removeEventListener( "mouseenter", this.handleMouseenter );
		this.element.removeEventListener( "mouseleave", this.handleMouseleave );

	}

}

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.Stimulus = Application.start();
// When not using the Ruby On Rails asset pipeline / build system, Stimulus doesn't know
// how to map controller classes to data-controller attributes. As such, we have to
// explicitly register the Controllers on Stimulus startup.
Stimulus.register( "hover-preload", HoverPreloadController );
