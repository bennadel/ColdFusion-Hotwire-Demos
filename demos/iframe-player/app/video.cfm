<cfscript>

	param name="url.id" type="string" default="";

	switch ( url.id ) {
		case "dojo-cat":
			src = "https://www.youtube.com/embed/TLiGA_wrNp0?autoplay=1";
		break;
		case "meghan-trainor":
			src = "https://www.youtube.com/embed/qDRORgoZxZU?autoplay=1";
		break;
		default:
			src = "";
		break;
	}

</cfscript>
<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />

		<base href="#request.appPath#/hotwire.cfm/" />
		<link rel="stylesheet" type="text/css" href="#request.appPath#/dist/main.css"></link>
	</head>
	<body>

		<h1>
			Video Player
		</h1>

		<turbo-frame id="player">

			<!---
				Only show the IFRAME when the SRC is defined. If there is no SRC, just
				return empty content, which will - for all intents and purposes - "close"
				the player. This isn't technically closing the player (ie, clearing the
				Turbo-Frame "src" attribute); but, it's good enough for this demo.
			--->
			<cfif src.len()>
				<iframe
					width="355"
					height="200"
					src="#src#"
					title="YouTube video player"
					frameborder="0"
					allow="autoplay; encrypted-media; picture-in-picture; web-share"
					allowfullscreen>
				</iframe>

				<!--- Hidden by default, only shows when inside injected player. --->
				<p class="player__close">
					<a href="video.htm?id=">
						Close Player
					</a>
				</p>
			</cfif>

		</turbo-frame>

		<p>
			<a href="index.htm">Back to Home</a>
		</p>

	</body>
	</html>

</cfoutput>
