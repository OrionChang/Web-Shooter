$(document).ready ->
	$("button#submit").click ->

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