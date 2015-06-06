var openTooltip, toggledTooltips;

toggledTooltips = [];

$(function() {
    initTooltip();
});

initTooltip = function() {
    $('[data-toggle="tooltip"]').each(function(index) {
        $(this).tooltip({
            animation: false
        });
    });    
        
    $('[data-toggle="tooltip-ajax"]').on('mouseover', function() {
        toggledTooltips.push($(this).attr('href'));
        openTooltip($(this));
    });
    
    return $('[data-toggle="tooltip-ajax"]').on('mouseout', function() {
        $(this).tooltip('destroy');
        toggledTooltips.splice(toggledTooltips.indexOf($(this).attr('href'), 1));
    });    
}

openTooltip = function(element) {
    $.ajax({
        type: 'GET',
        url: element.attr('href'),
        success: function(data) {
            if (toggledTooltips.indexOf(element.attr('href')) >= 0) {
                element.attr('title', data).tooltip({
                    trigger: 'manual',
                    html: 'true',
                    container: 'body',
                    animation: false,
                    placement: 'top'
                });
                element.tooltip('show');
            }
        },
        error: function(xhr) {
            element.attr('title', 'Failed to fetch tooltip data :(').tooltip({
                trigger: 'manual',
                placement: 'top'
            });
            element.tooltip('show');
        }
    });
};
