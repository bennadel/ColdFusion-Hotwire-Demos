<cfscript>

	// Since we're wrapping the generated content, we only care about the end-mode tag
	// execution. If we're in the start mode, just exit.
	if ( thistag.executionMode == "start" ) {

		exit method = "exitTemplate";

	}

	param name="attributes.title" type="string" default="";

</cfscript>

<!--- In end-mode tag execution, wrap (and override) the generated content. --->
<cfsavecontent variable="thistag.generatedContent">
	<cfoutput>

		<!doctype html>
		<html lang="en">
		<head>
			<meta charset="utf-8" />
			<meta name="viewport" content="width=device-width, initial-scale=1" />
			<title>
				#encodeForHtml( attributes.title )#
			</title>
			<link rel="stylesheet" type="text/css" href="./dist/main.css"></link>
			<script type="text/javascript" src="./dist/main.js" defer></script>
		</head>
		<body>

			<h1>
				Turbo CFML Testing
			</h1>

			<p>
				<a href="./index.cfm">Home</a> |
				<a href="./about.cfm">About</a> |
				<a href="./contact.cfm">Contact</a>
			</p>

			<hr />

			#thistag.generatedContent#

			<hr />

			<p>
				Page loaded at #timeFormat( now(), "HH:mm:ss" )#
			</p>

		</body>
		</html>

	</cfoutput>
</cfsavecontent>
