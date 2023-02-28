<cfscript>

	notes = application.noteService.getNotes().reverse();

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Notes
		</h2>

		<!---
			This Turbo Frame is LAZY LOADED and will inline the create-note form. The
			static contents of the form will be rendered as a fallback while the remote
			template is being loaded.
			--
			NOTE: The "transcluded" CSS class is included to help us hide elements of the
			form after it has been loaded and inlined by Turbo Drive.
		--->
		<turbo-frame
			id="create-frame"
			src="create.htm"
			data-turbo-permanent
			class="transcluded">
			<p>
				<a href="create.htm">Add Note</a>
			</p>
		</turbo-frame>

		<!---
			This Turbo Frame gives us a target to RELOAD after a new note has been added.
			The RELOAD functionality will be implemented as a custom Turbo Stream action.
		--->
		<turbo-frame id="notes-list">

			<ul>
				<cfloop item="note" array="#notes#">
					<li>
						#encodeForHtml( note.text )#
						&mdash;
						<a
							href="delete.htm?id=#encodeForUrl( note.id )#"
							data-turbo-method="delete"
							data-turbo-confirm="Delete this note?">
							Delete
						</a>
					</li>
				</cfloop>
			</ul>

			<cfif notes.len()>
				<p>
					<a
						href="clear.htm"
						data-turbo-method="delete"
						data-turbo-confirm="Delete all notes?">
						Clear all notes
					</a>
				</p>
			</cfif>

		</turbo-frame>

	</cfoutput>
</cfmodule>
