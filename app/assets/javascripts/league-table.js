var maxIndex = 0;

$(document).ready(function() {
    maxIndex = $("div.league-table-filter").data("max-index");
    updateLinks();
});

function selectMatchDay(id) {
  filterDatatable("match_day_id",id);
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
    $('.ajax-match-day-selector a#next').show();
  } else if(index > 0 && index < maxIndex) {
    $('.ajax-match-day-selector a#previous').show();
    $('.ajax-match-day-selector a#next').show();
    $('.ajax-match-day-selector span#separator').show();
  } else if(index === maxIndex) {
    $('.ajax-match-day-selector a#previous').show();+
    $('.ajax-match-day-selector a#next').hide();
    $('.ajax-match-day-selector span#separator').hide();
  }    
}
