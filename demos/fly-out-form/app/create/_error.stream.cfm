<cfscript>

	header
		statusCode = request.template.statusCode
		statusText = request.template.statusText
	;
	content
		type = "text/vnd.turbo-stream.html; charset=utf-8"
	;

</cfscript>
<!---
	Turbo Drive is expecting our POST request to do one of the following:

	1. Redirect to another page (upon successful execution).
	2. Re-render with a non-200 response (to show error messages).
	3. Respond with a set of Turbo Stream directives (to mutate the existing DOM).

	The problem that we face here is that our parent Turbo Frame has [target="_top"].
	Which means that if we re-render our form to show the errors, it will swap out the
	entire page content, not just the fly-out content. As such, in order to maintain the
	same page layout AND show errors, we need to use a Turbo Stream directive to REPLACE
	THE ENTIRE FORM, complete with errors, in order to update the view. This is why we
	wrapped the form in a DIV[id="note-form"] - so that we could hot-swap it!
--->
<turbo-stream action="replace" target="note-form">
	<template>

		<!--- !!! Reused Form UI !!! --->
		<cfinclude template="_form.cfm" />

	</template>
</turbo-stream>
