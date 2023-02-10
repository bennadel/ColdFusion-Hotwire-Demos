<cfscript>

	// Slowdown the load on the main page so that we can see any flashes of cached content
	// as the page navigation is occurring.
	sleep( 500 );

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h1>
			ColdFusion + Hotwire Back-Button Cache Demo
		</h1>

		<p>
			<a href="index.htm"><strong>Home</strong></a> -
			<a href="about.htm">About</a>
		</p>

		<hr />

		<h2>
			Welcome to Our Site!
		</h2>

		<p>
			Copy, copy, copy....
		</p>

		<h2>
			Lazy Loaded Content
		</h2>

		<turbo-frame id="home-frame" src="frame.htm">
			<p>
				Frame content is eagerly-loading....
			</p>
		</turbo-frame>

		<!---
			This Controller will dynamically change the runtime styles of all the P tags.
			This will help illustrate how and when the page cache is populated (and then
			later restored or previewed).
		--->
		<button
			data-controller="magic"
			data-action="magic##changeDom"
			data-magic-selector-param="p"
			data-magic-styles-param='{
				"border": "3px dashed red",
				"background-color": "yellow"
			}'>
			Change Runtime Styles
		</button>

	</cfoutput>
</cfmodule>
