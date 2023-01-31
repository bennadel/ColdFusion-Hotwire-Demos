<cfscript>

	param name="url.quoteIndex" type="numeric" default=0;

	// NOTE: In a production environment, this would be cached in the application scope.
	// But, to keep things simple, I'm just re-instantiating it on each request.
	quotes = new lib.Quotes();

	// Select the quote to render on the page.
	quote = ( url.quoteIndex )
		? quotes.getQuote( val( url.quoteIndex ) )
		: quotes.getRandomQuote()
	;

</cfscript>

<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h1>
			ColdFusion + Hotwire Slide Show Demo
		</h1>

		<!---
			While we want the slideshow to be in its own turbo-frame, so that it can
			operate without altering the rest of the page state, we still want the slide-
			show navigation buttons to change the URL so that a page refresh (or a copy-
			paste of the current URL) will result in the currently-rendered quote being
			re-rendered (as dictated by "url.quoteIndex"). As such, I'm including the
			[data-turbo-action] attribute value "advance". This will keep the DOM updates
			locked-down to the frame while replacing / updating the URL.
		--->
		<turbo-frame id="quote-frame" data-turbo-action="advance">

			<figure class="m1-quote">
				<blockquote class="m1-quote__quote">
					#encodeForHtml( quote.excerpt )#
				</blockquote>
				<figcaption class="m1-quote__caption">
					&mdash; #encodeForHtml( quote.author )#
				</figcaption>
			</figure>

			<!---
				Since these navigation links are inside a turbo-frame element, they will
				be used to replace the contents of THIS FRAME ONLY (id="quote-frame"),
				leaving the rest of the page content untouched.
				--
				NOTE: I originally tried to include the [data-turbo-preload] attribute to
				pre-fetch the Prev/Next pages; but, the preload feature does not work with
				turbo-frames at this time - https://github.com/hotwired/turbo/issues/857
			--->
			<div class="m2-controls">
				&larr;
				<a href="index.htm?quoteIndex=#encodeForUrl( quote.prevIndex )#">
					Prev quote
				</a>
				|
				<a href="index.htm?quoteIndex=#encodeForUrl( quote.nextIndex )#">
					Next quote
				</a>
				&rarr;
			</div>

		</turbo-frame>

		<p>
			<!--- This content will NOT BE ALTERED during slide show navigation. --->
			Page originally loaded with quote index (#encodeForHtml( url.quoteIndex )#).
		</p>

	</cfoutput>
</cfmodule>
