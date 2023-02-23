<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h2>
			Welcome to My Site
		</h2>

		<div id="messages">
			This content will be replaced by the TURBO-STREAM actions below.
		</div>

		<turbo-frame id="async-frame" src="frame.htm">
			<!--- Will be loaded asynchronously. --->
		</turbo-frame>

		<!--- ---------------------------------------------------------------------- --->
		<!--- ---------------------------------------------------------------------- --->

		<!---
			Notice that the following Turbo-Stream elements are NOT part of a traditional
			"text/vnd.turbo-stream.html" response - they are being defined right inline
			with the page content. On load, Turbo Drive will locate them, apply the DOM
			(Document Object Model) transformations, and then remove them.
		--->

		<turbo-stream action="update" target="messages">
			<template>
				<p class="inline-action">
					This is the first message.
					I have <strong>reset</strong> the messages container.
				</p>
			</template>
		</turbo-stream>

		<turbo-stream action="append" target="messages">
			<template>
				<p class="inline-action">
					This is the second message.
				</p>
			</template>
		</turbo-stream>

	</cfoutput>
</cfmodule>
