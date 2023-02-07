<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<h1>
			ColdFusion + Hotwire Local Time Controller Demo
		</h1>

		<div
			id="demo"
			data-controller="local-time"
			data-local-time-tick-count-value="#getTickCount()#"
			data-local-time-day-time-class="local-time--day"
			data-local-time-night-time-class="local-time--night"
			class="local-time">
			Your local time:

			<!---
				Once the Stimulus controller is bound, the text inside this span will be
				replaced with a formatted time string.
			--->
			<span data-local-time-target="label">
				Unknown
			</span>
		</div>

		<p>
			<a href="logout.htm">Logout</a>
		</p>

		<!---
			When Stimulus binds Controllers to the DOM (Document Object Model) tree, it
			also starts to track changes to the DOM using the MutationObserver API. This
			means we can make runtime changes to the DOM from outside the Controller and
			Stimulus will turn around and trigger the Controller's life-cycle hooks. In
			this case, we'll change the "tick-count" value attribute, which will, in turn,
			trigger a re-render of the time.
			--
			NOTE: This is done, in part, because Stimulus "best practices" seem to try and
			treat the DOM as the "source of truth" for the state of the components. This
			approach allows HTML to be dynamically re-rendered with much less friction.
		--->
		<p>
			Dynamically set attribute:
			<a href="javascript:( window.demo.setAttribute( 'data-local-time-tick-count-value', new Date( '2023-02-06T11:30:00-05:00' ).getTime() ) ); void( 0 );">Set to Day</a> ,
			<a href="javascript:( window.demo.setAttribute( 'data-local-time-tick-count-value', new Date( '2023-02-06T03:15:00-05:00' ).getTime() ) ); void( 0 );">Set to Night</a>
		</p>

	</cfoutput>
</cfmodule>
