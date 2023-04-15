<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<!--- Parent controller. --->
		<form data-controller="form">

			<!---
				The textarea controller has methods for manipulating the text value in
				low-level ways so that the complexity of text manipulation doesn't have to
				leak up and out into the form itself. This also increases the ability to
				reuse the text formatting practices in different places.
			--->
			<textarea
				data-controller="textarea"
				data-form-target="textarea"
			></textarea>

			<!---
				These buttons ask the FORM to apply different formatting styles (which
				will turn around and ask the textarea controller to apply the formatting).
			--->
			<button
				type="button"
				data-action="form##applyFormatting"
				data-form-command-param="bold">
				Bold
			</button>
			<button
				type="button"
				data-action="form##applyFormatting"
				data-form-command-param="italic">
				Italic
			</button>
			<button
				type="button"
				data-action="form##applyFormatting"
				data-form-command-param="strikethrough">
				Strike-Through
			</button>

		</form>

	</cfoutput>
</cfmodule>
