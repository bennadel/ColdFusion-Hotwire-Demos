
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
	"turbo:load",
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

class LocalTimeController extends Controller {

	// These static values tell Stimulus which DOM attribute to map to which JavaScript
	// class properties. When the Controller is instantiated, a good number of getters
	// and setters are automatically generated based on the following names.
	static classes = [
		"dayTime",
		"nightTime"
	];
	static targets = [
		"label"
	];
	static values = {
		tickCount: Number
	};

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I run once after the component instance has been bound to the host DOM element. At
	* this point, all of the classes, targets, and values have already been bound.
	*/
	connect() {

		console.info( "Controller connected." );
		this.renderTime();

	}


	/**
	* I get called once after the component instance has been unbound from the host DOM
	* element. At this point, all of the targets have already been disconnected as well.
	*/
	disconnect() {

		console.info( "Controller disconnected." );

	}


	/**
	* I get called once after the "label" target is connected to the controller instance.
	* This gets called BEFORE the main connect() call-back.
	*/
	labelTargetConnected( node ) {

		console.log( "Label target connected." );

	}


	/**
	* I get called anytime the "tick-count" value is changed (including the value
	* initialization). This will get called once BEFORE the main connect() call-back.
	*/
	tickCountValueChanged( newValue, oldValue ) {

		console.group( "Tick Count Changed" );
		console.log( "New value:", newValue );
		console.log( "Old value:", oldValue );
		console.groupEnd();

		if ( ! oldValue ) {

			// When the tickCount value is first set (upon controller initialization), the
			// previous value is "0" (the default). We know that the initial rendering of
			// the local time will be handled by the connect callback; as such, we only
			// want to respond when the value changes occur after the connect event.
			return;

		}

		// Update the rendering to reflect the new time!
		this.renderTime();

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I update the rendering of the local-time label based on the bound tick-count.
	*/
	renderTime() {

		// Using the server-provided UTC milliseconds value, let's instantiate a Date
		// object in the user's local timezone. This will give us access to locale-
		// specific formatting.
		var localTime = new Date( this.tickCountValue );
		// To make the demo more interesting, I'm arbitrarily classifying some hours as
		// "night" and other hours as "day" so that I can use some CSS class bindings.
		var isNightTime = (
			( localTime.getHours() < 7 ) ||
			( localTime.getHours() > 19 )
		);

		this.labelTarget.textContent = localTime.toLocaleTimeString();

		if ( isNightTime ) {

			this.element.classList.remove( this.dayTimeClass );
			this.element.classList.add( this.nightTimeClass );

		} else {

			this.element.classList.remove( this.nightTimeClass );
			this.element.classList.add( this.dayTimeClass );

		}

	}

}

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.Stimulus = Application.start();
// When not using the Ruby On Rails asset pipeline / build system, Stimulus doesn't know
// how to map controller classes to data-controller attributes. As such, we have to
// explicitly register the Controllers on Stimulus startup.
Stimulus.register( "local-time", LocalTimeController );
