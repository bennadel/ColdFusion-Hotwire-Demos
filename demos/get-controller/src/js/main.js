
// Import core modules.
import { Application } from "@hotwired/stimulus";
import { Controller } from "@hotwired/stimulus";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export class FormController extends Controller {

	static targets = [ "textarea" ];

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I apply the given formatting command event to the nested textarea.
	*/
	applyFormatting( event ) {

		this.application
			// Stimulus gives us the ability to extract a Controller instance from a given
			// element. However, since a given element can have any number of controllers
			// attached	to it, we have to provide an IDENTIFIER that tells Stimulus which
			// controller to extract. In this case, we're looking for the one with the
			// "textarea" identifier. I'm OK with the tight-coupling here because we are
			// explicitly deferring work to another controller.
			.getControllerForElementAndIdentifier( this.textareaTarget, "textarea" )
			// Then, once we have the controller instance, we can invoke methods on it
			// like we would with any other JavaScript object.
			.formatSelection( event.params.command )
		;

	}

}


export class TextareaController extends Controller {

	/**
	* I apply the given style command to the currently-selected text.
	*/
	formatSelection( style ) {

		switch ( style ) {
			case "bold":
				this.wrapSelection( "**" );
			break;
			case "italic":
				this.wrapSelection( "_" );
			break;
			case "strikethrough":
				this.wrapSelection( "~~" );
			break;
			default:
				throw( new Error( `Unsupported text format: ${ style }` ) );
			break;
		}

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I wrap the current selection in the given prefix/suffix markers.
	*/
	wrapSelection( prefix, suffix = prefix ) {

		var value = this.element.value;
		var start = this.element.selectionStart;
		var end = this.element.selectionEnd;

		var wrappedValue = (
			value.slice( 0, start ) +
			prefix +
			value.slice( start, end ) +
			suffix +
			value.slice( end )
		);

		this.element.value = wrappedValue;
		this.element.selectionStart = ( start + prefix.length );
		this.element.selectionEnd = ( end + prefix.length );
		this.element.focus();

	}

}

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

window.Stimulus = Application.start();
// When not using the Ruby On Rails asset pipeline / build system, Stimulus doesn't know
// how to map controller classes to data-controller attributes. As such, we have to
// explicitly register the Controllers on Stimulus startup.
Stimulus.register( "form", FormController );
Stimulus.register( "textarea", TextareaController );
