<cfscript>

	param name="request.context.action" type="string";
	param name="request.context.selector" type="string";

</cfscript>
<cfcontent type="text/vnd.turbo-stream.html; charset=utf-8" />
<cfoutput>

	<!---
		Note that this CUSTOM Turbo-Stream action is accepting a **SELECTOR** attribute.
		The SELECTOR attribute allows us to target portions of the TEMPLATE element such
		that we can more flexibly reuse existing interfaces (by including them, but
		selecting only a portion of the interface as the Turbo-Stream payload).
	--->
	<turbo-stream
		action="#request.context.action#"
		selector="#request.context.selector#"
		target="demo-container">
		<template>
			<p class="new replace-with">
				Selected via 'replaceWith'
			</p>
			<p class="new update-with">
				Selected via 'updateWith'
			</p>
			<p class="new prepend-with">
				Selected via 'prependWith'
			</p>
			<p class="new append-with">
				Selected via 'appendWith'
			</p>
			<p class="new before-with">
				Selected via 'beforeWith'
			</p>
			<p class="new after-with">
				Selected via 'afterWith'
			</p>
		</template>
	</turbo-stream>

</cfoutput>
