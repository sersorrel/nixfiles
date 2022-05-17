{ ... }:

{
  xdg.enable = true;
  xdg.mimeApps = {
    enable = true;
    # TODO: delegate filetype associations to individual applications?
    # (the difficulty is that some of them are installed systemwide)
    associations.added = {
      "application/json" = "vim.desktop";
      "application/x-shellscript" = "vim.desktop";
      "application/gzip" = "org.gnome.FileRoller.desktop";
      "application/xhtml+xml" = "vim.desktop";
      "application/xml" = "vim.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
      "image/png" = [ "glimmer.desktop" "org.gnome.eog.desktop" ];
      "image/x-dds" = "glimmer.desktop";
      "text/html" = "vim.desktop";
      "text/markdown" = "vim.desktop";
      "text/plain" = "vim.desktop";
      "text/x-java" = "vim.desktop";
      "text/x-makefile" = "vim.desktop";
      "text/x-python" = "vim.desktop";
      "x-scheme-handler/kdeconnect" = "nemo.desktop";
    };
    associations.removed = {
      "audio/mp4" = "org.kde.kid3-qt.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "calibre-ebook-edit.desktop" "calibre-gui.desktop" "calibre-ebook-viewer.desktop" ];
    };
    defaultApplications = {
      "application/pdf" = "org.gnome.Evince.desktop";
      "application/x-desktop" = "vim.desktop";
      "image/gif" = "org.gnome.eog.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
      "image/png" = "org.gnome.eog.desktop";
      "image/x-dds" = "glimmer.desktop";
      "text/html" = "google-chrome.desktop";
      "text/markdown" = "vim.desktop";
      "x-scheme-handler/about" = "google-chrome.desktop";
      "x-scheme-handler/http" = "google-chrome.desktop";
      "x-scheme-handler/https" = "google-chrome.desktop";
      "x-scheme-handler/kdeconnect" = "nemo.desktop";
      "x-scheme-handler/mailto" = "google-chrome.desktop";
      "x-scheme-handler/unknown" = "google-chrome.desktop";
      "x-scheme-handler/webcal" = "google-chrome.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
    };
  };
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
