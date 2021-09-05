{ ... }:

{
  xdg.enable = true;
  xdg.mimeApps = {
    enable = true;
    # TODO: delegate filetype associations to individual applications?
    # (the difficulty is that some of them are installed systemwide)
    associations.added = {
      "application/x-shellscript" = "vim.desktop";
      "audio/mpeg" = "org.gnome.Totem.desktop";
      "audio/x-wav" = "org.gnome.Totem.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
      "image/png" = "org.gnome.eog.desktop";
      "text/markdown" = "vim.desktop";
      "text/plain" = "vim.desktop";
      "text/x-python" = "vim.desktop";
    };
    associations.removed = {};
    defaultApplications = {
      "audio/mpeg" = "org.gnome.Totem.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
      "image/png" = "org.gnome.eog.desktop";
      "text/html" = "google-chrome.desktop";
      "text/markdown" = "vim.desktop";
      "x-scheme-handler/about" = "google-chrome.desktop";
      "x-scheme-handler/http" = "google-chrome.desktop";
      "x-scheme-handler/https" = "google-chrome.desktop";
      "x-scheme-handler/mailto" = "google-chrome.desktop";
      "x-scheme-handler/unknown" = "google-chrome.desktop";
      "x-scheme-handler/webcal" = "google-chrome.desktop";
    };
  };
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
