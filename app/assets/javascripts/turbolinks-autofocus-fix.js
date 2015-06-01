// Fix for autofocus and Turbolinks issues.
// https://github.com/rails/turbolinks/issues/365
$(document).bind('page:load', function() {
    return $('input[autofocus="autofocus"]').focus();
});

