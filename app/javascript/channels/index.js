// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.


//= require typeahead.bundle.js
const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

$(document).on('turbolinks:load', function(){
  var mybooks = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/mybooks/autocomplete?query=%QUERY',
      wildcard: '%QUERY'
    }
  });
  $('#mybooks_search').typeahead(null, {
    source: mybooks
  });
})