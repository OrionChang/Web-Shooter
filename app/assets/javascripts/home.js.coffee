# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

readyToGo = true


$(document).ready ->

	$(document).delegate "#new_webshot .new-webshot-submit", "click", ->
		$('#myModal').modal('show')

	$(document).delegate ".share-by-email-submit", "click", ->

		if readyToGo == true

			readyToGo = false
			datafrom = $(this).attr('data-from')
			url = $(this).attr('data-to')
			data = $(datafrom + " form").serialize()
			$.ajax
				type: "POST"
				dataType : 'json'
				url: url
				data: data
				success: ->

		        error: ->


$(document).ajaxSuccess (event, request, settings) ->

	html = "<div class='alert alert-success' style='margin:0px'><a class='close' data-dismiss='alert'>&#215;</a>" + JSON.parse(request.responseText).message + "</div>"
	$("#notice").append(html)

$(document).ajaxError (event, request, settings) ->

	html = "<div class='alert alert-danger' style='margin:0px'><a class='close' data-dismiss='alert'>&#215;</a>" + JSON.parse(request.responseText).message + "</div>"
	$("#notice").append(html)


$(document).ajaxSend (event, request, settings) ->

	html = "<div class='alert alert-info' style='margin:0px'><a class='close' data-dismiss='alert'>&#215;</a> Please wait for seconds.</div>"
	$("#notice").append(html)
	$(".modal").modal("hide")

$(document).ajaxComplete (event, request, settings) ->

	readyToGo = true





