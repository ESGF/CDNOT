# Django 2.2 update for COG Python3

## Purpose

All sites running CoG should install the most recent version of the Django package, If your site still runs a Django 1.x / Python2 configuration please consider the following to upgrade:  https://github.com/EarthSystemCoG/COG/blob/master/COG_py3_setup.md  Those instructions will install the most recent 2.2.x Django,  at this time is 2.2.24

## Steps

If you have followed the procedure, you will have generated a new conda environment for CoG running under Python3 called `cog_py3` and the mod_wsgi express service running under `/etc/cog-wsgi-8889`.  Also ensure that your superuser account effectively writes world-readable files (eg. `umask 227`)

```
    sudo bash  # or other command to effectively become root
    # activate conda (there are other means to do so, example below)
    source /usr/local/conda/etc/profile.d/conda.sh
    # Activate your conda environment
    conda activate cog_py3
    #  stop the service
    /etc/cog-wsgi/8889/apachectl -k stop
    # use pip to upgrade Django to the most recent version (2.2.24)
    pip install --upgrade Django==2.2.24
    # Restart the service
    /etc/cog-wsgi/8889/apachectl -k start
    # if CoG doesn't come up you may need to restart the httpd service as well
    systemctl restart httpd
```
