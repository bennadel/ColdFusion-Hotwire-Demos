
// Import core modules.
import { Application } from "@hotwired/stimulus";
import { Controller } from "@hotwired/stimulus";
import * as Turbo from "@hotwired/turbo";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

// By default, we don't want Turbo Drive to take over the navigation unless explicitly
// enabled within the ColdFusion markup. This way, we can baby-step our way towards a
// compatible Turbo Drive application.
Turbo.session.drive = false;

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

class AppController extends Controller {

	/**
	* I get called whenever the controller instance is bound to a host element.
	*/
	connect() {

		console.log( "App connected!" );
		// Wire-up all the features that have not yet been ported to their own Stimulus
		// controllers. Keep in mind that these methods will be called on every page load.
		setupOldSchoolThing();

	}

}

window.Stimulus = Application.start();
// When not using the Ruby On Rails asset pipeline / build system, Stimulus doesn't know
// how to map controller classes to data-controller attributes. As such, we have to
// explicitly register the Controllers on Stimulus startup.
Stimulus.register( "app", AppController );

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

function setupOldSchoolThing() {

	// This setup method will be called on every page load. As such, it will only be
	// applicable some of the time. If this page doesn't contain an old-school widget,
	// exit out.
	if ( ! document.querySelector( ".old-school" ) ) {

		console.warn( "No old-school widget detected." );
		return;

	}

	var dom = Object.create( null );
	dom.container = document.querySelector( ".old-school" );
	dom.button = dom.container.querySelector( "button" );
	dom.counter = dom.button.querySelector( "span" );

	// Parse initial counter from the DOM state.
	var clickCount = +dom.counter.textContent;

	dom.button.addEventListener(
		"click",
		function handleClick() {

			dom.counter.textContent = ++clickCount;

		}
	);

}
