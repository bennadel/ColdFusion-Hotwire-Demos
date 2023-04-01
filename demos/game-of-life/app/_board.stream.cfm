<cfscript>

	header
		statusCode = request.template.statusCode
		statusText = request.template.statusText
	;
	content
		type = "text/vnd.turbo-stream.html; charset=utf-8"
	;

</cfscript>
<turbo-stream action="replace" target="board">
	<template>

		<cfinclude template="_board.cfm" />

	</template>
</turbo-stream>
