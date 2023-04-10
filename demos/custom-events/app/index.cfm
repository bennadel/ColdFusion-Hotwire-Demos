<cfscript>

	emojis = [
		{
			name: "Grinning Face",
			hex: "1F600"
		},
		{
			name: "Heart",
			hex: "2764 FE0F"
		},
		{
			name: "Fire",
			hex: "1F525"
		}
	];

</cfscript>
<cfmodule template="./tags/page.cfm">
	<cfoutput>

		<div id="myDiv">
			<p>
				<input id="myInput" type="text" autofocus />
			</p>
			<p>
				<cfloop item="emoji" array="#emojis#">

					<button
						data-controller="emoji"
						data-action="emoji##emitEmoji"
						data-hex="#encodeForHtmlAttribute( emoji.hex )#">
						#encodeForHtml( emoji.name )#
					</button>

				</cfloop>
			</p>
		</div>

		<!--- LEGACY LOGIC. --->
		<script type="text/javascript">

			// Even though our Emoji controller is a Stimulus controller, the events that
			// it emits are still native DOM (Document Object Model) events. Which means,
			// we can create "bridge" code that glues our legacy logic and our Hotwire
			// logic together as we migrate a legacy application. In this case, I'm going
			// to listen for the custom event, "emoji" (from the "emoji" controller), and
			// then use it to insert the desired emoji into the input using the following
			// legacy logic.
			myDiv.addEventListener(
				"emoji:emoji",
				( event ) => {

					console.group( "Emoji Event" );
					console.log( "Glyph:", event.detail.emoji );
					console.log( "Hex:", event.detail.hex );
					console.log( "Codepoints:", event.detail.codepoints );
					console.groupEnd();

					// Legacy logic to insert emoji in input.
					var insertAt = myInput.selectionEnd;
					var nextSelectionAt = ( insertAt + event.detail.emoji.length );

					myInput.value = (
						myInput.value.slice( 0, insertAt ) +
						event.detail.emoji +
						myInput.value.slice( insertAt )
					);
					myInput.focus();
					myInput.selectionStart = myInput.selectionEnd = nextSelectionAt;

				}
			);

		</script>

	</cfoutput>
</cfmodule>
