root = exports ? this
root.Home = ( ->

  init = (page) ->
    if page == 'index'
      configure_tinymce()
      config_form()
      configure_vote()
      configure_order()


  config_form = () ->
    $("#new_request").on("ajax:success", (e, data, status, xhr) ->
      $('#request_title').val('')
      tinyMCE.activeEditor.setContent('')
      refresh_list()
      configure_vote()
    ).on("ajax:error", (e, xhr, status, error) ->
      console.log 'error'
    )

  configure_tinymce = () ->
    tinymce.init({
      selector: 'textarea#request_description',
      menubar: false,
      statusbar: false,
      plugins: [
        "advlist autolink lists link image charmap print preview anchor",
        "searchreplace visualblocks code fullscreen",
        "insertdatetime media table paste imagetools wordcount"
      ]
    })

  configure_vote = () ->
    $(".vote").unbind().on 'click', (e) ->
      e.preventDefault()
      request_id = $(this).data("request-id")
      action = $(this).data("vote-action")
      $.ajax(
        url: "/requests/#{request_id}/vote",
        data: { vote_action: action },
        type: 'POST'
      ).done((data) ->
        $("#vote_section_#{request_id}").html(data)
        configure_vote()
      )

  configure_order = () ->
    $("#order").on 'change', (e) ->
      e.preventDefault()
      refresh_list()


  refresh_list = () ->
    order = $('#order').val()
    $.ajax(
      url: "/requests",
      data: {
        order: order
      }
      type: 'GET'
    ).done((data) ->
      $("#list_row").html(data)
    )

  { init: init }
)()
