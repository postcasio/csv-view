{ScrollView, $} = require 'atom'
path = require 'path'
fs = require 'fs'
csv = require 'csv'

class CsvView extends ScrollView
	@content: ->
		@div class: 'csv-view', =>
			@table outlet: 'table'

	initialize: (@path) ->
		body = $ '<tbody>'
		count = 0
		csv().from.path @path
		.on 'record', (data) =>
			row = $ '<tr>'
			for col in data
				row.append $ '<td>', text: col
			body.append row
		.on 'end', =>
			@table.append body

	getTitle: ->
		path.basename @path


module.exports =
	activate: (state) ->
		atom.workspace.registerOpener (uri) ->
			if path.extname(uri) is '.csv'
				return new CsvView uri
