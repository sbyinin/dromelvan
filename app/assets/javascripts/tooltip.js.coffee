toggledTooltips = []
    
$ ->
  $('[data-toggle="tooltip"]').on 'mouseover', ->
    toggledTooltips.push $(this).attr('href')
    openTooltip($(this))
    return    
  $('[data-toggle="tooltip"]').on 'mouseout', ->
    $(this).tooltip('destroy')
    toggledTooltips.splice toggledTooltips.indexOf $(this).attr('href'), 1
    return    

openTooltip = (element) ->
  $.ajax
    type: 'GET'
    url: element.attr('href')
    success: (data) ->
      if toggledTooltips.indexOf(element.attr('href')) >= 0
        element.attr('title', data).tooltip
          trigger: 'manual'
          html: 'true'
          container: 'body'
          animation: false
          placement: 'top'
        element.tooltip 'show'
      return
    error: (xhr) ->
      element.attr('title', 'Failed to fetch tooltip data :(').tooltip(
        trigger: 'manual'
        placement: 'top')
      element.tooltip('show')
      return
  return


