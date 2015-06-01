// See http://jqueryui.com/autocomplete/#categories for explanation of what's going on here.
$.widget("custom.catcomplete", $.ui.autocomplete, {
    _renderMenu: function(ul, items) {
        var currentCategory, that;
        that = this;
        currentCategory = "";
        $.each(items, function(index, item) {
            if (item.category !== currentCategory) {
                ul.append("<li class='ui-autocomplete-category'>" + item.category + "</li>");
                currentCategory = item.category;
            }
            that._renderItemData(ul, item);
        });
    },
    _renderItem: function(ul, item) {
        return $("<li></li>").data("ui-autocomplete-item", item).append("<a href='" + item.path + "'>" + item.name + "</a>").appendTo(ul);
    }
});

$(function() {
    $("#search_q").catcomplete({
        delay: 500,
        minLength: 2,
        source: function(request, callback) {
            $.getJSON("/live_search.json", {
                search: {
                    q: request.term
                }
            }, callback);
        },
        focus: function(event, ui) {
            $("#search_q").val(ui.item.name);
            return false;
        },
        select: function(event, ui) {
            window.location = ui.item.path;
            return true;
        }
    });
});
