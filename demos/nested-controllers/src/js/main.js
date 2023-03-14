
// Import core modules.
import { Application } from "@hotwired/stimulus";
import { Controller } from "@hotwired/stimulus";
import * as Turbo from "@hotwired/turbo";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //
/*
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
*/

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

class ParentController extends Controller {

	/**
	* I log the event when the button in the CHILD HTML is used to invoke an action on
	* this PARENT controller instance.
	*/
	logAction( event ) {

		console.group( "Parent Action [%s]", event.type );
		console.log( "Child ID:", event.params.childId );
		console.log( "Child Data:", event.params.childData );
		console.groupEnd();

	}

	/**
	* I log the event that the CHILD controller emits up the DOM tree.
	*/
	logEvent( event ) {

		console.group( "Parent Event [%s]", event.type );
		console.log( "Child ID:", event.detail.id );
		console.groupEnd();

	}

}


class ChildController extends Controller {

	static values = {
		id: Number
	};

	/**
	* I emit a demo event up the DOM tree where any higher-up controller can bind to it.
	*/
	emitEvent() {

		this.dispatch(
			"hello",
			{
				detail: {
					id: this.idValue
				}
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
Stimulus.register( "parent", ParentController );
Stimulus.register( "child", ChildController );
