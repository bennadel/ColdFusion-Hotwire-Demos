<cfscript>

	// Since we're wrapping the generated content, we only care about the end-mode tag
	// execution. If we're in the start mode, just exit.
	if ( thistag.executionMode == "start" ) {

		exit method = "exitTemplate";

	}

</cfscript>

<!--- In end-mode tag execution, wrap (and override) the generated content. --->
<cfsavecontent variable="thistag.generatedContent">
	<cfoutput>

		<!doctype html>
		<html lang="en">
		<head>
			<meta charset="utf-8" />
			<meta name="viewport" content="width=device-width, initial-scale=1" />
			<!---
				The "no-preview" directive tells Turbo Drive to not show a cached version
				during an "application visit" (ie, clicking a link, submitting a form);
				but, that caching can still be used for "restore visits" (ie, hitting the
				browser's back button).
			--->
			<!--- <meta name="turbo-cache-control" content="no-preview" /> --->
			<title>
				ColdFusion + Hotwire Demo
			</title>

			<!---
				CAUTION: Since Hotwire Turbo Drive needs to work with ".htm" files, I'm
				configuring the base HREF to apply relative paths as the PATH_INFO after
				the "hotwire.cfm" file (which doesn't exist). The onRequest() event
				handler (in Application.cfc) will then dynamically execute the
				corresponding ".cfm" file by swapping the ".htm" file-extension with a
				".cfm" file-extension.
				--
				NOTE: This is just for a local demo - I would not use this approach in a
				production setting (I'd use more robust URL rewriting).
			--->
			<base href="#request.appPath#/hotwire.cfm/" />

			<!---
				CAUTION: Since I'm setting the base-href to route through a ColdFusion
				file, our static assets have to use root-absolute paths so that they
				bypass the base tag settings.
			--->
			<script src="#request.appPath#/dist/main.js" defer async></script>
			<link rel="stylesheet" type="text/css" href="#request.appPath#/dist/main.css"></link>
		</head>
		<body>

			<h1>
				ColdFusion + Hotwire ... Demo
			</h1>

			<hr />

			#thistag.generatedContent#

			<hr />

			<p>
				Page loaded at #timeFormat( now(), "HH:mm:ss.l" )#
			</p>

			<!--- BEGIN: Toaster. --->
			<div
				data-controller="toaster"
				data-action="turbo:before-cache@document->toaster##handleBeforeCache"
				data-toaster-animate-in-class="in"
				data-toaster-animate-out-class="out"
				class="toaster">

				<!---
					NEW TOAST: All new toast items in the current request are rendered
					into this container. These toasts will then be moved (on before-cache)
					into the OLD container for cross-navigation persistence.
				--->
				<div data-toaster-target="new" class="toaster__new">
					<cfloop item="newToast" array="#request.newToasts#">

						<div
							data-action="
								click->toaster##removeToast
								animationend->toaster##handleAnimationEnd
							"
							class="toaster__toast in"><!-- Note the "in" class. -->
							#newToast#
						</div>

					</cfloop>
				</div>

				<!---
					OLD TOAST: By marking this element as PERMANENT, it will be cached
					(in its runtime rendered state) across navigation events (both for
					restoration and application visits). This container will therefore
					allow the toasts to persist (until a hard-refresh).
				--->
				<div
					id="toaster__old"
					data-toaster-target="old"
					data-turbo-permanent
					class="toaster__old">
					<!--- To be populated by the Stimulus controller. --->
				</div>
			</div>
			<!--- END: Toaster. --->

		</body>
		</html>

	</cfoutput>
</cfsavecontent>
