$(function () {
  var handler = Gmaps.build('Google');
  handler.buildMap({ internal: {id: 'map_canvas'}}, function(){
    var marker_data = $('#marker_data').data().markers;
    var markers = handler.addMarkers(marker_data);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });
});
