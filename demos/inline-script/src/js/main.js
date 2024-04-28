
// Import core modules.
import * as Turbo from "turbo-cfml";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

var turboEvents = [
	// "turbo:before-cache",
	// "turbo:before-fetch-request",
	// "turbo:before-fetch-response",
	// "turbo:before-frame-render",
	// "turbo:before-morph-attribute",
	// "turbo:before-morph-element",
	// "turbo:before-prefetch",
	"turbo:before-render",
	// "turbo:before-stream-render",
	// "turbo:before-visit",
	// "turbo:click",
	// "turbo:fetch-request-error",
	// "turbo:frame-load",
	// "turbo:frame-missing",
	// "turbo:frame-render",
	// "turbo:load",
	// "turbo:morph",
	// "turbo:morph-element",
	// "turbo:render",
	// "turbo:submit-end",
	// "turbo:submit-start",
	// "turbo:visit",
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
