# HTTPD Configuration

## Introduction

Given high volumes of http requests for files, data nodes could benefit from being reconfigured to serve files via apache httpd instead of thredds

## Steps

You will be modifying both `/etc/httpd/conf/esgf-httpd.conf` and `/etc/httpd/conf/httpd.ssl.conf` given a standard ESGF httpd deployment for apache httpd 2.4.

1. Remove old entries (these are too general):
   ```
        ProxyPass /thredds      ajp://localhost:8223/thredds
        ProxyPassReverse /thredds       ajp://localhost:8223/thredds

2. Add new thredds proxy entries
   ```
                ProxyPass /thredds/catalog      ajp://127.0.0.1:8223/thredds/catalog
        ProxyPassReverse /thredds/catalog       ajp://127.0.0.1:8223/thredds/catalog
        
        ProxyPass /thredds/dodsC        ajp://127.0.0.1:8223/thredds/dodsC
        ProxyPassReverse /thredds/dodsC         ajp://127.0.0.1:8223/thredds/dodsC
        
3. Add aliases for fileServer paths. These should mirror the THREDDS dataset roots, eg. `<datasetRoot path="esg_dataroot" location="/esg/data"/>`,
also configured via the publisher in esg.ini
   ```
        Alias "/thredds/fileServer/esg_dataroot" "/esg/data"
        
4. If you have both restricted and unrestricted data, you'll need to 
   (a) ensure the `Alias` paths above go to your unrestricted data
   
   ```
        Alias "/thredds/fileServer/esg_dataroot/CMIP6" "/esg/data/CMIP6"
   ```
   
  (b) add `ProxyPass` directives for restricted data, eg
   
   ```
        ProxyPass /thredds/fileServer/esg_dataroot/cordex ajp://127.0.0.1:8223/thredds/fileServer/esg_dataroot/cordex
        ProxyPassReverse /thredds/fileServer/esg_dataroot/cordex ajp://127.0.0.1:8223/thredds/fileServer/esg_dataroot/cordex       
   ```
   
  5. restart httpd

## Going further: catalogs

You may want to disable catalogs for external access, but enabled for internal.  Use this rule:

```
  <Location /thredds/catalog*>
         Require ip 10 198.128.245 128.115.184 128.115.57 128.15
         ErrorDocument 403 "Thredds catalogs are temporarily disabled"
 </Location>
```

To disable catalog access altogether, remove the ProxyPass rule from (2), then add this rule:
```
        AliasMatch "^/thredds/catalog.*$" "/var/www/html/catalog.html"
```
