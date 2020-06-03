{ config, pkgs, ... }: {
  services.httpd.virtualHosts =
    let commonConfig = {
          adminAddr = "alice@example.org";
          forceSSL = true;
          enableACME = true;
        } in { "blog.example.org" = (commonConfig // { documentRoot = "/webroot/blog.example.org"; });
               "wiki.example.org" = (commonConfig // { documentRoot = "/webroot/wiki.example.com"; })
             };

  services.httpd.virtualHosts =
    let makeVirtualHost = webroot:
          { documentRoot = webroot;
            adminAddr = "alice@example.org";
            forceSSL = true;
            enableACME = true;
          } in { "blog.example.org" = (makeVirtualHost "/webroot/blog.example.org");
                 "wiki.example.org" = (makeVirtualHost "/webroot/wiki.example.com");
               };
}
