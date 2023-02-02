<cfscript>

	param name="attributes.counter" type="struct";

</cfscript>
<cfoutput>

	<!---
		Turbo Stream directives are driven by IDs. As such, we have to include an ID in
		our counter view rendering.
	--->
	<div id="#encodeForHtmlAttribute( attributes.counter.id )#" class="m1-counter">
		<div class="m1-counter__value">
			#encodeForHtml( attributes.counter.value )#
		</div>
		<div class="m1-counter__body">
			<!---
				This form will either INCREMENT or REMOVE the current counter. In a
				non-Turbo Drive world, this would direct the whole page to the given
				action. However, if Turbo Drive intercepts the action, it will be
				performed via fetch() and we have a chance to respond with a Turbo Stream
				that will update the rendered DOM (Document Object Model).
			--->
			<form method="post" class="m1-counter__form">
				<input type="hidden" name="id" value="#encodeForHtmlAttribute( attributes.counter.id )#" />

				<button type="submit" formAction="increment.htm">
					Increment
				</button>
				<button type="submit" formAction="remove.htm">
					Remove
				</button>
			</form>

			<span class="m1-counter__timestamp">
				Counter rendered at #timeFormat( now(), "HH:mm:ss.l" )#
			</span>
		</div>
	</div>

</cfoutput>

<!--- This tag does not expect any body content. --->
<cfexit method="exitTag" />
