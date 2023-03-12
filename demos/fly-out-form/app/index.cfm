<cfscript>

	notes = application.noteService.getNotes();

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Welcome to My Site
		</h2>

		<p>
			<!---
				We're opening our note form into a Turbo Frame AND we're advancing the
				location URL. This way, if someone were to refresh the page, they would
				still be presented with the note form (albeit no longer located within the
				Turbo Frame / Fly-out panel).
			--->
			<a
				href="create/index.htm"
				data-turbo-frame="fly-out-frame"
				data-turbo-action="advance">
				Add note
			</a>
		</p>

		<ul>
			<cfloop item="note" array="#notes#">
				<li>
					#encodeForHtml( note.text )#
				</li>
			</cfloop>
		</ul>

		<!---
			Our Fly-Out Turbo Frame will use [target="_top"] so that any navigation events
			or redirects within the frame will be applied to the top-level page. This will
			make it possible/easier to REDIRECT BACK TO THE MAIN PAGE with up-to-date note
			information after an embedded fly-out form mutates the application state.
		--->
		<turbo-frame
			id="fly-out-frame"
			target="_top">
		</turbo-frame>

	</cfoutput>
</cfmodule>
