<cfoutput>

	<!---
		This wrapper DIV serves to give us a target that we can REPLACE with a Turbo
		Stream directive if / when we need to re-render the form with error messages.
	--->
	<div id="note-form">
		<h2>
			Add Note
		</h2>

		<cfif errorMessage.len()>
			<p class="error-message">
				#encodeForHtml( errorMessage )#
			</p>
		</cfif>

		<form method="post" action="create/index.htm">
			<p>
				<input type="text" name="text" size="40" autofocus />
			</p>
			<p>
				<button type="submit">
					Add Note
				</button>
				<a href="index.htm">
					Cancel
				</a>
			</p>
		</form>
	</div>

	<!---
		This script tag will be executed every time the view is merged into the page,
		whether as the initial rendering or as part of a Turbo Stream action. I'm using it
		to focus the input. THe [autofocus] attribute works on the first render, but not
		on the subsequent rendering. This script tag makes up the difference.
	--->
	<script type="text/javascript">
		document.querySelector( "input[name='text']" ).focus();
	</script>

</cfoutput>
