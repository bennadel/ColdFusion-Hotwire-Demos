
// Import core modules.
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
	"turbo:before-stream-render",
	"turbo:render",
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
