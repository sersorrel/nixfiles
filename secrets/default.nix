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
  };
}
