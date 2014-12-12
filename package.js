Package.describe({
  summary: "Live marker sets for Google Maps based on Meteor cursors.",
  version: "0.1.0",
  git: "https://github.com/singlow/meteor-live-maps.git",
  name: "live-maps"
});

Package.on_use(function(api) {
  api.use("coffeescript", "client");

  if (api.export) {
    api.export("LiveMaps", "client");
  }

  api.add_files("live-maps-client.coffee", "client");
});

