Live Google Maps for Meteor
===========================

This package allows you to turn any cursor into a set of live markers on
a google map canvas.

```js
LiveMaps.addMarkersToMap(
  map: googleMapObject,
  cursors: [ {
    cursor: Places.find(),
    transform: function(document) {
      return {
        title: document.firstName + ' ' + document.lastName,
        position: new google.maps.LatLng(document.address.location[1], document.address.location[0]),
        animation: google.maps.Animation.BOUNCE,
        icon: '//cdn.mydomain.com/icons/icon-house.png'
      };
    }
  } ]
```

The markers options should be an object or array of objects specifying
a cursor and a transform function that will generate the arguments
to the google.maps.Marker constructor. If no transform is provided,
a default transform function will look for several possible sources
of a title and a latitude and longitude and optionally an icon and
animation property.

The default transformation will look for top level properties called lat,
latitude, lon, lng, or longitude, or an array called location with a
pair of values [longitude, latitude]. The array version is compatible
with mongo geospatial indexes. It will also look for properties name,
title or label to populate the marker title. So if your collection has
these properties already, you don't need a transform unless you need
to customize another property of the marker.

This package expects google maps to be loaded when it is used, but it
does not require any particular smart package to provide it. It may be
provided by another package or included directly in your app as long
as the expected google namespace is available globally. There is an
atmosphere package called googlemaps that will include the api for you.
