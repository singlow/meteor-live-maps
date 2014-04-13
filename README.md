Live Google Maps for Meteor
===========================

This package allows you to turn any cursor into a set of live markers on
a google map canvas.

```js
LiveMaps.addMarkers({
  map: googleMapObject,
  markers: [
    { cursor: Places.find(), transform: function(a) {} }
  ]
}
```

The markers options shoule be an object or array of objects specifying
a cursor and a transform function that will generate the arguments
to the google.maps.Marker constructor. If no transform is provided,
a default transform function will look for several possible sources
of a title and a latitude and longitude.
