<cfcontent type="text/vnd.turbo-stream.html; charset=utf-8" />
<cfoutput>

	<!--- Refresh the create form Turbo Frame. --->
	<turbo-stream
		action="visit"
		data-url="create.htm"
		data-frame="create-frame">
	</turbo-stream>

	<!--- Refresh the list of notes Turbo Frame. --->
	<turbo-stream
		action="visit"
		data-url="index.htm"
		data-frame="notes-list">
	</turbo-stream>

</cfoutput>
