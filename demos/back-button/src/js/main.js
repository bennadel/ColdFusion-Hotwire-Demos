
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
	"turbo:render",
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

class MagicController extends Controller {

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I run once after the component instance has been bound to the host DOM element. At
	* this point, all of the classes, targets, and values have already been bound.
	*/
	connect() {

		console.info( "Controller connected." );

	}


	/**
	* I get called once after the component instance has been unbound from the host DOM
	* element. At this point, all of the targets have already been disconnected as well.
	*/
	disconnect() {

		console.info( "Controller disconnected." );

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I alter the runtime styles of the DOM for the purposes of testing the cache.
	*/
	changeDom( event ) {

		document.querySelectorAll( event.params.selector ).forEach(
			( node ) => {

				Object.assign( node.style, event.params.styles );

			}
		);

	}

}

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.Stimulus = Application.start();
// When not using the Ruby On Rails asset pipeline / build system, Stimulus doesn't know
// how to map controller classes to data-controller attributes. As such, we have to
// explicitly register the Controllers on Stimulus startup.
Stimulus.register( "magic", MagicController );
