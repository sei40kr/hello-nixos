{ config, pkgs, ... }:

{
  # Note that both modularity.nix and kde.nix define the option
  # environment.systemPackages. When multiple modules define an option, NixOS will
  # try to merge the definitions. In the case of environment.systemPackages,
  # that's easy: the lists of packages can simply be concatenated. The value in
  # modularity.nix is merged last, so for list-type options, it will appear at
  # the end of the merged list.
  imports = [ ./vpn.nix ./kde.nix ];
  services.httpd.enable = true;
  environment.systemPackages = [ pkgs.emacs ];
  # If you want it to appear first, you can mkBefore:
  boot.kernelModules = mkBefore [ "kvm-intel" ];

  # When using multiple modules, you may need to access configuration values
  # defined in other modules. This is what the config function argument is for:
  # it contains the complete, merged system configuration. That is, config is
  # the result of combining the configurations returned by every module.
  environment.systemPackages =
    if config.services.xserver.enable then
      [ pkgs.firefox
        pkgs.thunderbird ]
    else
      [ ];

  # While abstracting your configuration, you may find it useful to generate
  # modules using code, instead of writing files. The example below would have
  # the same effect as importing a file which sets those options.
  let netConfig = { hostName }: {
        networking.hostName = hostName;
        networking.useDHCP = false;
      };
  in
    { imports = [ (netConfig "nixos.localdomain") ] }
}
