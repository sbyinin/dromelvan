var maxIndex = 0;

$(".content.show-table").ready(function() {    
    maxIndex = $("div.league-table-filter").data("max-index");
    updateLinks();
});

function selectMatchDay(id) {
  filterDatatable($("div.league-table-filter").data("filter-column"),id);
  updateLinks();
}
  
function traverse(value) {
  var index = $('div.league-table-filter select').prop("selectedIndex") + value;
  if(index >= 0 && index <= 37) {
    $('div.league-table-filter select').prop("selectedIndex", index);
    selectMatchDay($('div.league-table-filter select').val());
  }
}

function updateLinks() {
  var index = $('div.league-table-filter select').prop("selectedIndex")
  if(index === 0) { 
    $('.ajax-match-day-selector a#previous').hide();
    $('.ajax-match-day-selector span#separator').hide();
    if(maxIndex > 0) {
        $('.ajax-match-day-selector a#next').show();
    } else {
        $('#traverse-links').hide();
    }
  } else if(index > 0 && index < maxIndex) {
    $('#traverse-links').show();
    $('.ajax-match-day-selector a#previous').show();
    $('.ajax-match-day-selector a#next').show();
    $('.ajax-match-day-selector span#separator').show();
  } else if(index === maxIndex) {
    $('#traverse-links').show();
    $('.ajax-match-day-selector a#previous').show();+
    $('.ajax-match-day-selector a#next').hide();
    $('.ajax-match-day-selector span#separator').hide();
  }
  
  var id = $('div.league-table-filter select').val();
  var href = $('div.league-table-filter li#match-day-link a').attr('href');
  var text = $('div.league-table-filter li#match-day-link a').text();
  var oldId = href.split("/").pop();
  
  $('div.league-table-filter li#match-day-link a').text(text.replace(/\d+/i, index + 1));
  $('div.league-table-filter li#match-day-link a').attr('href', href.replace(oldId,id))
}
