{ lib, ... }:

{
  imports = [
    ./secrets.nix
  ];

  options.secrets = {
    name = lib.mkOption {
      type = with lib.types; nullOr string;
      default = null;
      description = ''
        Your full name.
      '';
    };
    email = lib.mkOption {
      type = with lib.types; nullOr string;
      default = null;
      description = ''
        Your email address.
      '';
    };
    latitude = lib.mkOption {
      type = with lib.types; nullOr float;
      default = null;
      description = ''
        Your latitude, between -90 and 90.
      '';
    };
    longitude = lib.mkOption {
      type = with lib.types; nullOr float;
      default = null;
      description = ''
        Your longitude, between -180 and 180.
      '';
    };
    userOptions = lib.mkOption {
      description = ''
        Additional options (e.g. the password) for the primary user.
      '';
    };
    wifi = lib.mkOption {
      default = {};
      description = ''
        WiFi networks to automatically connect to (see networking.wireless.networks).
      '';
    };
  };
}
