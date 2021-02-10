# HTTPD Configuration

## Introduction

Given high volumes of http requests for files, data nodes could benefit from being reconfigured to serve files via apache httpd instead of thredds

## Steps

1. remove old entries (these are too general):

```
        ProxyPass /thredds      ajp://localhost:8223/thredds
        ProxyPassReverse /thredds       ajp://localhost:8223/thredds
```
