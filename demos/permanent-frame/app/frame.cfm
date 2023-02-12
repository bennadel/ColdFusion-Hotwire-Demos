<cfscript>

	// Adding latency so that we can see the place-holder text and tell more clearly that
	// the frame content is being loaded asynchronously.
	sleep( 1000 );

</cfscript>
<turbo-frame id="home-frame">
	<cfoutput>
		<p>
			Frame loaded at #timeFormat( now(), "HH:mm:ss" )#.
		</p>
		<p>
			<button data-action="perm-frame##reload">
				Reload Frame
			</button>
		</p>
	</cfoutput>
</turbo-frame>
