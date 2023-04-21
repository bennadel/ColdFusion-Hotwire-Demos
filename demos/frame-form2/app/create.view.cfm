<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Add Note
		</h2>

		<turbo-frame id="create-frame" target="_top">

			<cfif errorMessage.len()>
				<p class="error-message">
					#encodeForHtml( errorMessage )#
				</p>
			</cfif>

			<form method="post" action="create.htm">
				<p>
					<input type="text" name="text" size="40" autofocus />
				</p>
				<p>
					<button type="submit">
						Add Note
					</button>

					<!---
						This cancel button will be hidden (via the CSS class) when it is
						transcluded into the main page.
					--->
					<a href="index.htm" class="hide-if-transcluded">
						Cancel
					</a>

					<!---
						If this form is being transcluded into the main page, and it has
						an error message, let's show a button to clear / reset the form
						(to remove the error message). Depending on the type of form you
						have, this may not be necessary.
					--->
					<cfif errorMessage.len()>
						<a
							href="create.htm"
							data-turbo-frame="_self"
							class="show-if-transcluded inline">
							Reset
						</a>
					</cfif>
				</p>
			</form>

			<!--- Help the autofocus attribute work on subsequent frame-loads. --->
			<script type="text/javascript">
				document.querySelector( "input[autofocus]" )
					?.focus()
				;
			</script>

		</turbo-frame>

	</cfoutput>
</cfmodule>
