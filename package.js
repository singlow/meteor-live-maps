Package.describe({
  summary: "Live marker sets for Google Maps based on Meteor cursors."
});

Package.on_use(function(api) {
  api.use("coffeescript", "client");

  if (api.export) {
    api.export("LiveMaps", "client");
    console.log("LiveMaps exported");
  }

  api.add_files("live-maps-client.coffee", "client");
  console.log("LiveMaps files have been included");
});

