$( document ).ready(function() {
  $("#mailjet-widget").on("submit", function (e) {
    e.preventDefault();
    var url = "addContact?"+$("#mailjet-widget").serialize();
    $.post( url, function( data ) {
      alert(data.count);
    });
  });
});
