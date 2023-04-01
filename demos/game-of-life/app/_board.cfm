<cfoutput>

	<!---
		In our Game of Life board, each living cell is being represented by a CHECKBOX
		whose value denotes the "x,y" coordinates of the cell within the infinite canvas.
		On each subsequent page load, the checkbox will be CHECKED if its composite "x,y"
		key still exists in the index of living cells.
		--
		NOTE: We are including an ID on the board so that we can replace its rendering via
		a Turbo Stream action.
	--->
	<div id="board" class="board">
		<cfloop index="y" from="#state.minY#" to="#state.maxY#">
			<div>
				<cfloop index="x" from="#state.minX#" to="#state.maxX#">
					<label>
						<input
							type="checkbox"
							name="cells[]"
							value="#x#,#y#"
							<cfif state.cellIndex.keyExists( "#x#,#y#" )>checked</cfif>
						/>
					</label>
				</cfloop>
			</div>
		</cfloop>
	</div>

</cfoutput>
