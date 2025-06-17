{
  services.flatpak = {
    enable = true;
    packages = [
      # "fr.handbrake.ghb"
      # "fr.handbrake.ghb.Plugin.IntelMediaSDK"
      # "md.obsidian.Obsidian"
      # "app.zen_browser.zen"
      # "io.github.celluloid_player.Celluloid"
      # "de.haeckerfelix.Shortwave"
    ];
    update.auto = {
      enable = true;
      onCalendar = "weekly"; # Default value
    };
  };
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";
}

