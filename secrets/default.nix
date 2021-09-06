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
      type = with lib.types; nullOr (submodule {
        options = {
          url = lib.mkOption {
            type = str;
            description = ''
              URL which the Talon beta can be downloaded from.
            '';
          };
          sha256 = lib.mkOption {
            type = str;
            description = ''
              SHA256 hash of the Talon beta.
            '';
          };
          version = lib.mkOption {
            type = str;
            description = ''
              The version number of the Talon beta.
            '';
          };
        };
      });
      default = null;
      description = ''
        Download details for the Talon beta.
      '';
    };
    irc = lib.mkOption {
      default = {};
      description = ''
        IRC network configuration.
      '';
      type = with lib.types; attrsOf (submodule {
        options = {
          servers = lib.mkOption {
            description = ''
              List of servers to attempt connections to.
            '';
            type = listOf (submodule {
              options = {
                host = lib.mkOption {
                  type = str;
                };
                port = lib.mkOption {
                  type = port;
                };
                ssl = lib.mkOption {
                  default = true;
                  type = bool;
                };
                default = lib.mkOption {
                  default = false;
                  type = bool;
                };
              };
            });
          };
          nicks = lib.mkOption {
            type = listOf str;
          };
          username = lib.mkOption {
            type = nullOr str;
          };
          realname = lib.mkOption {
            type = nullOr str;
          };
          encoding = lib.mkOption {
            type = enum [
              "UTF-8 (Unicode)"
              "CP1252 (Windows-1252)"
              "ISO-8859-15 (Western Europe)"
              "ISO-8859-2 (Central Europe)"
              "ISO-8859-7 (Greek)"
              "ISO-8859-8 (Hebrew)"
              "ISO-8859-9 (Turkish)"
              "ISO-2022-JP (Japanese)"
              "SJIS (Japanese)"
              "CP949 (Korean)"
              "KOI8-R (Cyrillic)"
              "CP1251 (Cyrillic)"
              "CP1256 (Arabic)"
              "CP1257 (Baltic)"
              "GB18030 (Chinese)"
              "TIS-620 (Thai)"
            ];
            default = "UTF-8 (Unicode)";
          };
          logintype = lib.mkOption {
            type = enum [
              "default"
              "sasl"
              "saslExternal"
              "slashPass"
              "msgNickserv"
              "slashNickserv"
              "challengeAuth"
              "custom"
            ];
            default = "default";
          };
          password = lib.mkOption {
            type = nullOr str;
            default = null;
          };
          commands = lib.mkOption {
            type = listOf str;
            default = [];
          };
          channels = lib.mkOption {
            type = listOf str;
            default = [];
          };
          roundRobin = lib.mkOption {
            type = bool;
            default = true;
          };
          useSsl = lib.mkOption {
            type = bool;
            default = true;
          };
          autoConnect = lib.mkOption {
            type = bool;
            default = false;
          };
          useProxy = lib.mkOption {
            type = bool;
            default = true;
          };
          allowInvalidSsl = lib.mkOption {
            type = bool;
            default = false;
          };
          favourite = lib.mkOption {
            type = bool;
            default = false;
          };
        };
      });
    };
  };
}
