# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ───────────────────────────────────────────────────────────────────────────────
  # Boot Configuration
  # ───────────────────────────────────────────────────────────────────────────────
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "i915.modeset=1"
    "i915.fastboot=1"
    "i915.enable_guc=2"
    "i915.enable_psr=1"
    "i915.enable_fbc=1"
    "i915.enable_dc=2"
  ];

  # ───────────────────────────────────────────────────────────────────────────────
  # Locale, Timezone & Input
  # ───────────────────────────────────────────────────────────────────────────────
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver.xkb = {
    layout = "pt";
    variant = "mac";
  };
  console.keyMap = "pt-latin1";

  # ───────────────────────────────────────────────────────────────────────────────
  # Users
  # ───────────────────────────────────────────────────────────────────────────────
  users.users.fabio = {
    isNormalUser = true;
    description = "Fábio Barbosa";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [ ];
  };

  # ───────────────────────────────────────────────────────────────────────────────
  # Hardware - Graphics
  # ───────────────────────────────────────────────────────────────────────────────
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };
  hardware.enableRedistributableFirmware = true;

  # ───────────────────────────────────────────────────────────────────────────────
  # Hardware - Logitech
  # ───────────────────────────────────────────────────────────────────────────────
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  # ───────────────────────────────────────────────────────────────────────────────
  # Networking
  # ───────────────────────────────────────────────────────────────────────────────
  networking.hostName = "marshmallow";
  networking.networkmanager.enable = true;
  networking.nameservers = [ 
    "9.9.9.9"
    "149.112.112.112" 
    "2620:fe::fe"
    "2620:fe::9"
  ]; 

  # ───────────────────────────────────────────────────────────────────────────────
  # Audio
  # ───────────────────────────────────────────────────────────────────────────────
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };

  # ───────────────────────────────────────────────────────────────────────────────
  # Printing
  # ───────────────────────────────────────────────────────────────────────────────
  services.printing.enable = true;

  # ───────────────────────────────────────────────────────────────────────────────
  # Power Management
  # ───────────────────────────────────────────────────────────────────────────────
  services = {
    power-profiles-daemon.enable = false;
    fwupd.enable = true;
    thermald.enable = true;
    logind.extraConfig = "HandlePowerKey=ignore";
    tlp = {
      enable = true;
      settings = {
        STOP_CHARGE_THRESH_BAT0 = "85";
        START_CHARGE_THRESH_BAT0 = "80";
        CPU_BOOST_ON_AC = "0";
        CPU_MAX_PERF_ON_AC = "100";
        CPU_MAX_PERF_ON_BAT = "30";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };
    thinkfan = {
      enable = true; # Problems with L450: https://github.com/NixOS/nixpkgs/issues/395739
      levels = [
        [ "level auto"       0  60  ]
        [ 7                  60 70  ]
        [ "level full-speed" 70 150 ]
      ];
      sensors = [
        #{ type = "tpacpi"; query = "/proc/acpi/ibm/thermal"; }    
        { type = "hwmon"; query = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon7/temp1_input"; }
        #{ type = "hwmon"; query = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon7/temp2_input"; }
        { type = "hwmon"; query = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon7/temp3_input"; }
        { type = "hwmon"; query = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon7/temp4_input"; }
        { type = "hwmon"; query = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon7/temp5_input"; }
        { type = "hwmon"; query = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon7/temp6_input"; }
        { type = "hwmon"; query = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon7/temp7_input"; }
        { type = "hwmon"; query = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon7/temp8_input"; }
        { type = "hwmon"; query = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input"; }
        { type = "hwmon"; query = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp2_input"; }
        { type = "hwmon"; query = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp3_input"; }
        { type = "hwmon"; query = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp4_input"; }
        { type = "hwmon"; query = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp5_input"; }
        { type = "hwmon"; query = "/sys/devices/pci0000:00/0000:00:1d.2/0000:3d:00.0/nvme/nvme0/hwmon0/temp1_input"; }
        { type = "hwmon"; query = "/sys/devices/pci0000:00/0000:00:1d.2/0000:3d:00.0/nvme/nvme0/hwmon0/temp2_input"; }
        { type = "hwmon"; query = "/sys/devices/virtual/thermal/thermal_zone2/hwmon3/temp1_input"; }
        { type = "hwmon"; query = "/sys/devices/virtual/thermal/thermal_zone3/hwmon4/temp1_input"; }
        { type = "hwmon"; query = "/sys/devices/virtual/thermal/thermal_zone6/hwmon8/temp1_input"; } 
      ];
    };
  };

  # ───────────────────────────────────────────────────────────────────────────────
  # Virtualisation (Host)
  # ───────────────────────────────────────────────────────────────────────────────
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      vhostUserPackages = [ pkgs.virtiofsd ];
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;

  # ───────────────────────────────────────────────────────────────────────────────
  # Nix Configuration
  # ───────────────────────────────────────────────────────────────────────────────
  nix.optimise.automatic = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ───────────────────────────────────────────────────────────────────────────────
  # Miscellaneous
  # ───────────────────────────────────────────────────────────────────────────────
  documentation.nixos.enable = false;

  # ───────────────────────────────────────────────────────────────────────────────
  # System Version
  # ───────────────────────────────────────────────────────────────────────────────
  system.stateVersion = "25.05";

}
