<turbo-frame id="async-frame">

	<p>
		This is the async FRAME content.
	</p>

	<!---
		In order for these inline Turbo-Stream elements to be picked up and applied to the
		live document, they have to be included inside of the Turbo-Frame element.
		Otherwise, they will not be transcluded into the calling page and will, therefore,
		be de facto discarded.
	--->

	<turbo-stream action="append" target="messages">
		<template>
			<p class="inline-action inline-action--async">
				This was injected via the async <strong>Turbo-Frame</strong> response.
			</p>
		</template>
	</turbo-stream>

</turbo-frame>
