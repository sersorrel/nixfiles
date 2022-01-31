{ config, ... }:

{
  config = {
    # TODO: only if graphical
    services.gammastep = {
      # TODO: enable this only if we have geoclue or a lat/long
      enable = true;
      latitude = config.secrets.latitude;
      longitude = config.secrets.longitude;
      tray = true;
      # TODO: set provider to geoclue2 if possible
      temperature.day = 6500;
      temperature.night = 3600;
    };
  };
}
