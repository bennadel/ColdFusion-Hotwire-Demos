<cfcontent type="text/vnd.turbo-stream.html; charset=utf-8" />
<cfoutput>

	<!---
		When streaming an error back to the client, we don't actually want to use the form
		view (complete with H1 element and so on). As such, we're going to include the
		whole view but update the UI with a SELECTOR that will only consume the matching
		node (and, in this case, only extract the .childNodes).
	--->
	<turbo-stream
		action="updateWith"
		target="create-frame"
		selector="##create-frame"
		child-nodes="true">
		<template>

			<cfinclude template="create.view.cfm" />

		</template>
	</turbo-stream>

</cfoutput>
