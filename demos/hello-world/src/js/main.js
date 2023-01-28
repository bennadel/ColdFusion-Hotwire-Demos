
// Import core modules.
import { Application } from "@hotwired/stimulus";
import { Controller } from "@hotwired/stimulus";
import * as Turbo from "@hotwired/turbo";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

class M1HeaderController extends Controller {

	static classes = [ "active" ];
	static targets = [ "yay" ];

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once when the controller instance is bound to the DOM.
	*/
	connect() {

		this.yayTimer = null;

	}


	/**
	* I get called once when the controller instance is removed from the DOM.
	*/
	disconnect() {

		clearInterval( this.yayTimer );

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I put the header into an activated state.
	*/
	activate() {

		this.element.classList.add( this.activeClass );
		this.yayTimer = setInterval( this.renderYay.bind( this ), 60 );

	}


	/**
	* I put the header into a deactivated state.
	*/
	deactivate() {

		this.element.classList.remove( this.activeClass );
		clearInterval( this.yayTimer );
		this.resetYay();

	}


	/**
	* I render a new yay state (animating the "!" mark).
	*/
	renderYay() {

		if ( this.yayTarget.textContent.length === 5 ) {

			this.yayTarget.replaceChildren();

		} else {

			this.yayTarget.textContent += "!";

		}

	}


	/**
	* I reset the yay state content.
	*/
	resetYay() {

		this.yayTarget.textContent = "";

	}

}

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.Stimulus = Application.start();

Stimulus.register( "m1-header", M1HeaderController );
