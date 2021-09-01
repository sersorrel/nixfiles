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
    talon-beta = lib.mkOption {
      type = with lib.types; nullOr submodule {
        options = {
          url = lib.mkOption {
            type = string;
            description = ''
              URL which the Talon beta can be downloaded from.
            '';
          };
          sha256 = lib.mkOption {
            type = string;
            description = ''
              SHA256 hash of the Talon beta.
            '';
          };
          version = lib.mkOption {
            type = string;
            description = ''
              The version number of the Talon beta.
            '';
          };
        };
      };
      default = null;
      description = ''
        Download details for the Talon beta.
      '';
    };
  };
}
