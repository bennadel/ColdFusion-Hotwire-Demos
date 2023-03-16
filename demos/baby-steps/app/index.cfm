<cfscript>

	param name="url.quoteIndex" type="numeric" default=0;

	quote = application.quoteService.getQuote( url.quoteIndex );

</cfscript>
<cfmodule template="./tags/page.cfm" section="home">
	<cfoutput>

		<h2>
			Welcome to My Site
		</h2>

		<!---
			Even with Turbo Drive disabled by default, Turbo Frames still work. As such,
			for navigation events that refresh the page, we can very easily wrap those
			navigation elements in a Turbo Frame that advances the history.
		--->
		<turbo-frame id="quote-frame" data-turbo-action="advance">
			<figure>
				<blockquote>
					#encodeForHtml( quote.text )#
				</blockquote>
				<figcaption>
					&larr;
					<a href="index.htm?quoteIndex=#encodeForUrl( quote.prevID )#">Prev quote</a>
					&mdash;
					<a href="index.htm?quoteIndex=#encodeForUrl( quote.nextID )#">Next quote</a>
					&rarr;
				</figcaption>
			</figure>
		</turbo-frame>

		<p>
			Copy copy copy....
		</p>

		<!---
			This represents a "pre-Stimulus" widget. It will be bootstrapped by a page-
			level Stimulus controller until it can be migrated to use Stimulus on its own.
		--->
		<p class="old-school">
			<button>
				Clicked <span>0</span> Times
			</button>
		</p>

		<!---
			Even when Turbo Drive is disable by default, lazy-loaded Turbo Frames still
			work. Which means, we can VERY EASILY lazy-load content into the current page.
		--->
		<turbo-frame id="lazy-frame" src="lazy.htm" loading="lazy">
			<!--- Placeholder content (or if script hasn't loaded). --->
			<a href="lazy.htm">Go to lazy content</a> &rarr;
		</turbo-frame>

	</cfoutput>
</cfmodule>
