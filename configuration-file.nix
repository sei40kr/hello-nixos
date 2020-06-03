{ config, pkgs, ... }:

{ services.httpd.enable = true;
  services.httpd.adminAddr = "alice@example.org";
  services.httpd.virtualHosts.documentRoot = "/webroot";

  # Sets can be nested, and in fact dots in option names are shorthand for
  # defining a set containing another set.
  services = {
    httpd = {
      enable = true;
      adminAddr = "alice@example.org";
      virtualHosts = {
        localhost = {
          documentRoot = "/webroot";
        };
      };
    };
  };

  ## Strings

  # Strings are enclosed in double quotes.
  networking.hostName = "dexter";

  # Multi-line strings can be enclosed in double single quotes.
  networking.extraHosts =
    ''
      127.0.0.2 other-localhost
      10.0.0.1 server
    '';

  ## Booleans

  networking.firewall.enable = true;
  networking.firewall.allowPing = false;

  ## Integers

  # Note that here the attribute name net.ipv4.tcp_keepalive_time is enclosed in
  # quotes to prevent it from being interpreted as as set named net containing a
  # set named ipv4, and so on. This is becasue it's not a NixOS option but the
  # literal name of a Linux kernel setting.
  boot.kernel.sysctl."net.ipv4.tcp_keepalive_time" = 60;

  ## Sets

  fileSystems."/boot" =
    { device = "/dev/sda1";
      fsType = "ext4";
      options = [ "rw" "data=ordered" "relatime" ];
    };

  ## Lists

  boot.kernelModules = [ "fuse" "kvm-intel" "coretemp" ];

  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

  ## Packages

  environment.systemPackages =
    [ pkgs.thunderbird
      pkgs.emacs
    ];

  services.postgresql.package = pkgs.postgresql_10
}
