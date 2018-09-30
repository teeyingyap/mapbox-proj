$(document).ready(function () {
    L.mapbox.accessToken = 'pk.eyJ1IjoidGVleWluZ3lhcCIsImEiOiJjam1qYzg3MzYwZWFjM3ZvZXFndGpnc2VtIn0.eJaR7S6-ZPpuFA-Bg47haw';
  	var map = L.mapbox.map('map', 'mapbox.streets').setView([35.652832, 139.839478], 9);
    $.ajax({
      dataType: 'text',
      url: '/locations.json',
      success: function(data) {
        var geojson = $.parseJSON(data);
        map.featureLayer.setGeoJSON(geojson);
        console.log(map.featureLayer);
        console.log(geojson);
        map.featureLayer.eachLayer(function(marker) {
        	var popupContent = '<div class="popup">' + '<h3>' + marker.feature.properties.name + '</h3>' + '</div>';
        	marker.bindPopup(popupContent, {
        	  closeButton: false,
              maxWidth: 320
            });
    	});
      }
    });
    $('.card').click(function(e) {
  	  var current = $(this);
      var currentPark = current.find('p').text();
      map.featureLayer.eachLayer(function(marker) {
        if (marker.feature.properties.name == currentPark) {
          marker.openPopup();
        }
      });
    });
});
