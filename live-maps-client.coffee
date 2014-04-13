LiveMaps =
  addMarkersToMap: (map, cursors)->
    if typeof cursors isnt "array" then cursors = [cursors]
    queries = (liveMarkers(cursor) for cursor in cursors)
    # return method to destroy them when you are done
    return stop: -> do stopQuery for stopQuery in queries

liveMarkers = (cursor)->

  markers = []

  liveQuery = cursor.observe
    added: (newDoc)-> addMarker(newDoc)
    changed: (newDoc, oldDoc)->
      removeMarker(oldDoc)
      addMarker(newDoc)
    removed: (oldDoc)-> removeMarker(oldDoc)

  addMarker = (doc)->
    markers[marker._id] = new google.maps.Marker
      position: new google.maps.LatLng(doc.location[1], doc.location[0])
      map: map
      title: doc.title
      animation: doc.animation or google.maps.Animation.DROP
      icon: doc.icon or '//maps.google.com/mapfiles/ms/icons/green-dot.png'

  removeMarker = (doc)->
    markers[doc._id].setMap(null)
    delete markers[doc._id]

  return ->
    do liveQuery.stop
    marker.setMap(null) for marker in markers

unless Package?
  @LiveMaps = LiveMaps
