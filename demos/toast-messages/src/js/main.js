
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

class ToasterController extends Controller {

	static classes = [ "animateIn", "animateOut" ];
	static targets = [
		"new",
		// CAUTION: Because the "old" target is using "turbo-data-persistent", it will NOT
		// be available into the connect() callback. It will only be available after the
		// page has been fully loaded (I think).
		"old"
	];

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I handle the completed animation on the given target.
	*/
	handleAnimationEnd( event ) {

		var toastNode = event.currentTarget;

		// If the toast is currently exiting stage left, remove it from the DOM.
		if ( toastNode.classList.contains( this.animateOutClass ) ) {

			toastNode.remove();

		}

	}


	/**
	* I handle the moment just before the current page is put into the cache. This event
	* gives us a chance to manipulate the DOM before the cache snapshot is taken. In this
	* case, we're going to move all of the NEW toast elements in to the OLD toast
	* container so that they will be part of the "data-turbo-persistent" element.
	*/
	handleBeforeCache( event ) {

		// We need to loop over the NEW toasts BACKWARDS so that we can prepend them, in
		// order, to the OLD container. If we loop over it forward, the toasts will be
		// reversed in order as they are moved.
		[ ...this.newTarget.children ].reverse().forEach(
			( toastNode ) => {

				// Prevent any ENTER animation from firing. Otherwise, we'll see the
				// animation every time the OLD, persistent container is rendered from the
				// page cache.
				toastNode.classList.remove( this.animateInClass );
				// Move the toast from the NEW container into the OLD container.
				this.oldTarget.prepend( toastNode );

			}
		);

	}


	/**
	* I remove the associated toast from the toaster.
	*/
	removeToast( event ) {

		var toastNode = event.currentTarget;

		// By opting-out of the cache on the given node, we will prevent it from being
		// cached EVEN if it is inside the data-turbo-permanent element.
		toastNode.setAttribute( "data-turbo-cache", "false" );
		// Start animating the element out of view.
		toastNode.classList.add( this.animateOutClass );

	}

}

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.Stimulus = Application.start();
// When not using the Ruby On Rails asset pipeline / build system, Stimulus doesn't know
// how to map controller classes to data-controller attributes. As such, we have to
// explicitly register the Controllers on Stimulus startup.
Stimulus.register( "toaster", ToasterController );
