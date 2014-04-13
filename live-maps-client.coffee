LiveMaps =
  addMarkersToMap: (map, cursors)->
    queries = (liveMarkers(map, cursor) for cursor in cursors)
    # return method to destroy them when you are done
    return stop: -> do stopQuery for stopQuery in queries

liveMarkers = (map, cursor)->
  markers = []

  if cursor.observe
    transform = (doc)->
      position: new google.maps.LatLng(doc.latitude or doc.lat or doc.location[1], doc.longitude or doc.lon or doc.lng or doc.location[0])
      map: map
      title: doc.title or doc.name or doc.label
      animation: doc.animation or google.maps.Animation.DROP
      icon: doc.icon or '//maps.google.com/mapfiles/ms/icons/green-dot.png'
  else
    transform = cursor.transform
    cursor = cursor.cursor

  addMarker = (doc)->
    markers[doc._id] = new google.maps.Marker transform(doc)

  removeMarker = (doc)->
    markers[doc._id].setMap(null)
    delete markers[doc._id]

  liveQuery = cursor.observe
    added: addMarker
    changed: (newDoc, oldDoc)->
      removeMarker(oldDoc)
      addMarker(newDoc)
    removed: removeMarker

  return ->
    do liveQuery.stop
    marker.setMap(null) for marker in markers

unless Package?
  @LiveMaps = LiveMaps
