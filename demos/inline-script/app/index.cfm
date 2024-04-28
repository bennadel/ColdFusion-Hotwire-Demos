<cfmodule template="./tags/page.cfm" title="Welcome">
	<p>
		This is the <strong>Home</strong> page.
	</p>
	<p>
		Random number: <mark></mark>
	</p>

	<!---
		This INLINE script will execute every time the page renders. But, keep in mind
		that Hotwire Turbo may render the page multiple times in a single visit if it's
		pulling the page from the cache.
	--->
	<script type="text/javascript">

		var target = document.querySelector( "mark" );
		var randomNumber = Math.floor( Math.random() * 100 );

		// Appending the text (not assigning it) to show preview behavior.
		target.textContent += randomNumber;

		// Bind handler to test whether multiple events-handlers are around during various
		// types of navigation.
		target.addEventListener(
			"click",
			() => {

				alert( randomNumber );

			}
		);

		console.log( `Inline script executed: ${ randomNumber }.` );

	</script>
	<!---
		This INLINE script will execute every time the page renders as a fresh response.
		However, since it's marked as TEMPORARY, it will NOT execute when Hotwire Turbo is
		rendering the page from the cache (ie, a preview).
	--->
	<script type="text/javascript" data-turbo-temporary>

		console.log( "TEMPORARY inline script executed." );

	</script>
</cfmodule>
