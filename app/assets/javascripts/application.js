// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require ckeditor-jquery
//= require ckeditor/override
//= require ckeditor/init
//= require bootstrap.min
//= require scrollTo
//= require big_book
//= require entries
//= require landing
//= require static
//= require worksheet-entry

$.expr[":"].Contains = $.expr.createPseudo(function(arg) {
  return function( elem ) {
    return $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
  };
});

var entrySearchAndHighlight = function(searchTerm) {
  if (searchTerm === " ") { return ; }
  $('.highlighted').removeClass('highlighted');
  $("#entry-list-container #entry-index-item-body:contains('"+searchTerm+"')").html($('#entry-list-container #entry-index-item-body').html().replace(searchTerm,"<span class='highlighted'>"+searchTerm+"</span>"));
  $("#entry-list-container .entry-item-title a:contains('"+searchTerm+"')").html($('#entry-list-container .entry-item-title a').html().replace(searchTerm,"<span class='highlighted'>"+searchTerm+"</span>"));

  if($('.highlighted:first').length) {
    $('html').scrollTop($('.highlighted:first').offset().top);
  }
};

var bigbookSearchAndHighlight = function(searchTerm) {
  $('.highlighted').removeClass('highlighted');
  $("#chapter-view-panel:contains('"+searchTerm+"')").html($('#chapter-view-panel').html().replace(searchTerm,"<span class='highlighted'>"+searchTerm+"</span>"));
  
  if($('.highlighted:first').length) {
    $('html').scrollTop($('.highlighted:first').offset().top);
  }
};
