{ config, ... }:

{
  home.sessionPath = [ (toString ~/.local/bin) ];
}
