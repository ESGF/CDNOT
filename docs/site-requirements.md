# Requirements of sites hosting CMIP data

## Introduction

Sites that host CMIP6 data have originally consisted entirely of ESGF sites.  This notion has evolved with the advent of cloud-friendly storage.

ESGF consists of data infrastructure nodes of different complexity. In this document, two classes are distinguished: Tier-1 and 2 node sites. Tier 1 and Tier 2 nodes imply different requirements with respect to the ESGF infrastructure itself and with respect to ESGF data projects like CMIP6. The ESGF infrastructure requirements relate to node functionality, provided services and service levels in development, maintenance and operation. ESGF data project requirements focus more on physical infrastructure components adapted to the data project requirements.
In what follows, the requirements are formulated in more generic rather than concrete terms. In the case of CMIP6, data project node requirements for Tier 1 and Tier 2 sites contain concrete specifications as much as possible.

In addition to the ESGF Tiers, we identify a "Tier-3" for sites that make data available through means other than ESGF access.  For example, a project may rewrite CMIP6 datasets in Zarr format and store in S3 as done with an offering AWS cloud storage offering. 


## Tier-1 sites

Original Set of requirements.    Several ESGF sites run the stack and in those cases should follow the appropriate requirements.

- Have an uptime of >98%.
- Provide the complete stack of ESGF services: data node, index node, identity provider.
- Install the most recent version of ESGF software within one week.
- Prompt upgrade in case of detected security breaches (<7 days).
- Contribute to maintenance and operation.
- Run the ESGF testbed.
- Keep up to date any necessary certificates needed for the node operation and recognition, eg. web container, Globus Gridftp, filebeat for metrics.
- Support Tier 2 data nodes (installation, configuration, act as an index node).
- Support data providers in publishing operations.
- Are involved in primary data publication and data replication.
- Provide sufficient high-performance storage and network connections as required by
their supported data projects.
- Network connection: optimization of nominal bandwidth of 10 GBit/s will result in 30 – 50 % for real bandwidth for replication and data provision.
- Exclusion of data nodes: There is an ongoing proposition to enable ESGF to exclude a data node that does not satisfy all the CMIP6 requirements or a data node that will degrade the federation usability.
   - The implementation of this will revisited by WIP, coordinated with the ESGF-XC and CDNOT.

### Replica Tier-1 sites requirements

- Replica management:  when original dataset records are affected.
  - Retract replicas whose original version has been retracted. 
  - If an original dataset is updated, but the replica has not yet been updated --- for instance the data has yet to be discovered by Synda or transfer complete --- the old replica should be flagged as `latest=false` to make clear to users.
  - best effort to detect datasets that have been deleted and remove those replicas as well.

- CDNOT participation
  - Be subscribed to the CDNOT mailing list for announcements.
  - Regular attendance at CDNOT monthly meetings.  If there is difficulty in attending, please contact the CDNOT chair so alternate arragements, eg. rescheduling the meeting can be arranged.


### Data Usage Metrics collection

- All site hosting data nodes are required to participate in the ESGF automated reporting and collection of data usage metrics using the ESGF standard transimssion module.
  - As of ESGF software stack v4 (Ansible installation) this module is based on Filebeat.
  - The site may be contacted by the ESGF Stats team if metrics are not configured and assistance in setup will be provided.
- Site are required to have a client-side certificate signed by an ESGF CA for secure communication of metrics.

## Tier-2 sites

- Have an uptime of >90%.
- Provide the data node part of ESGF software stack.
- Install the most recent version of ESGF software within two weeks.
- Prompt upgrade in case of detected security breaches (<7 days).
- Be responsible for the node maintenance and operation.
- Exclusion of data nodes: There is an ongoing proposition to enable ESGF to exclude a data node that does not satisfy all the ESGF node operation requirements or a data node that will degrade the federation usability.
- Are involved in primary data publication.
- Provide sufficient storage and network bandwidth as required by their supported data projects.
- Spinning disks for initial data publication according to data project requirements.
- Network connection: 1 – 2 GBit/s for data provision.
- Keep up to date any necessary certificates needed for the node operation and recognition, eg. web container, Globus Gridftp, filebeat for metrics.

- Be subscribed to CDNOT mailing list for announcements.
- Regular CDNOT meeting attendance is strongly encouraged.
- Report metrics to the central ESGF collection site (see above).


## Tier-3 sites

Tier-3 sites effectively provide _replicas_ of CMIP6 datasets originally published to ESGF sites.  However these replicas are reformatted to something other than netCDF.  Several examples that we are use the Zarr format for the data placed in cloud-based object storage.  

### Responsibilities for Tier-3 sites

- Identify a site contact to be subscribed to the CDNOT list.
- Documentatio to refer users to official CMIP6 information so the users have an understanding of where to find metadata, for example: PIDs, citiations, ES-DOC errata.
- See Replica management guidelines for Tier-1 sites.  Consider that the Tier-3 site may not use an ESGF replica index so utilties eg reference implementations that compare esg-search records across indexes (original vs replica) would not apply in these cases so it is the responsibility of the site manager to develop procedures for this. 
