<!---
	EntityField Comment:
	- textAreas = A list of properties that are textareas
	- booleanSelect = If true creates a select box, else two radio buttons
	- manyToOne = { manyToOnePropertyName = {valuecolumn='',namecolumn='',criteria={},sortorder=""} }
		A structure of data to help with many to one relationships on how they are presented.
		Possible key values for each key are [valuecolumn='',namecolumn='',criteria={},sortorder=string]. Example: {criteria={productid=1},sortorder='Department desc'}
	- ManyToMany = { manyToManyPropertyName = {valuecolumn='',namecolumn='',criteria={},sortorder="",selectColumn='' }
		A structure of data to help with many to one relationships on how they are presented.
		Possible key values for each key are [valuecolumn='',namecolumn='',criteria={},sortorder=string,selectColumn='']. Example: {criteria={productid=1},sortorder='Department desc'}
	- showRelations = If true (default) will show one to many and one to one relations as a view table snapshot
--->

<cfoutput>
<h1>#args.title#</h1>

<!--- Submit Form --->
#html.startForm(action='explorer.texts.save')#

	<!--- Convert Entity To Fields --->
	#html.entityFields(entity=rc.text,
					   fieldWrapper="div class='controls'",
					   labelWrapper="",
					   textAreas="",
					   booleanSelect=true,
					   manyToOne={},
					   manyToMany={},
					   showRelations=true)#

	<!--- Submit --->
	<div class="form-actions">
	#html.href(href="explorer/texts", text="Cancel", class="btn")#
	#html.submitButton(value="Save", class="btn btn-primary")#
	</div>

#html.endForm()#
</cfoutput>