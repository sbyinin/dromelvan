# See http://jqueryui.com/autocomplete/#categories for explanation of what's going on here.
$.widget "custom.catcomplete", $.ui.autocomplete,
  _renderMenu: (ul, items) ->
    that = this
    currentCategory = ""
    $.each items, (index, item) ->
      unless item.category is currentCategory
        ul.append "<li class='ui-autocomplete-category'>" + item.category + "</li>"
        currentCategory = item.category
      that._renderItemData ul, item
      return

    return

  _renderItem: (ul, item) ->
    $("<li></li>").data("ui-autocomplete-item", item).append("<a href='" + item.path + "'>" + item.name + "</a>").appendTo ul

$ ->
  $("#search_q").catcomplete
    delay: 500
    minLength: 2
    source: (request, callback) ->
      
      # Using getJSON instead of just source: 'url' since we want the search term parameter to be 'search[:q]'
      # instead of just 'term'
      $.getJSON "/live_search.json",
        search:
          q: request.term
      , callback
      return

    focus: (event, ui) ->
      
      # Update the search field with the chosen value in the drop down.
      $("#search_q").val ui.item.name
      false

    select: (event, ui) ->
      
      # Visit the link for the chosen item.
      window.location = ui.item.path
      true

  return
