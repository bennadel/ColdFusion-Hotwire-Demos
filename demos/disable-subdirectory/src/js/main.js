
// Import core modules.
import * as Turbo from "@hotwired/turbo";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

document.documentElement.addEventListener(
	"turbo:click",
	function handleClick( event ) {

		// For the demo, we're going to allow any URL with [force=true] to be consumed by
		// Turbo Drive, regardless of where it is pointing to.
		if ( event.detail.url.includes( "force=true" ) ) {

			return;

		}

		// As we migrate an old site over to use Hotwire Turbo Drive, there may be a whole
		// host of links that point to old pages that are NOT NOW and WILL NEVER BE
		// compatible with the Turbo Drive requirements. We can hook into the Turbo Drive
		// events and prevent Hotwire from managing these archaic links.
		if ( event.detail.url.includes( "/resources/" ) ) {

			console.group( "Detected 'Resources' Subdirectory" );
			console.log( "URL:", event.detail.url );
			console.log( "Preventing default." );
			console.groupEnd();
			// Cancel this event to let the click fall through to the browser as normal
			// link navigation.
			event.preventDefault();

		}

	}
);
