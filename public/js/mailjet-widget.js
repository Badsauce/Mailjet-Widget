$( document ).ready(function() {
    $("#mailjet-widget").on("submit", function (e) {
      e.preventDefault();
      alert('Endpoint is working');
    });
});
