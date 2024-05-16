.. image:: ../images/otobo-logo.png
   :align: center
|

.. toctree::
    :maxdepth: 2
    :caption: Contents

Sacrifice to Sphinx
===================

Description
===========
A detailed service catalog.

System requirements
===================

Framework
---------
OTOBO 11.0.x

Packages
--------
 

Third-party software
--------------------
\-

Configuration Reference
=======================

Core::Acl
------------------------------------------------------------------------------------------------------------------------------

ServiceCatalog::CreateTypeServiceRelatedAcls
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This option allows you to automatically generate ACLs for different interfaces when creating services. Services will then only be displayed if the ticket type stored in the service has been selected.

ServiceCatalog::CreateTypeServiceRelatedAcls::Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Acl configuration für Type - Service restrictions. Please activate ServiceCatalog::CreateTypeServiceRelatedAcls before. For the key ConfigChange please use Possible or PossibleAdd. DeployNewACL deploy the changed acl Immediately.

Core::DynamicFields::ObjectTypeRegistration
------------------------------------------------------------------------------------------------------------------------------

DynamicFields::ObjectType###Service
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
DynamicField object registration.

Core::Event::Ticket
------------------------------------------------------------------------------------------------------------------------------

Ticket::EventModulePost###9700-SetDynamicFieldCriticalityFromService
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Event module registration. Currently, the criticality of the service can also be set in the service, but this has no effect. Therefore, this event module has been implemented that automatically updates the DynamicField Criticality in a ticket as soon as a service has been assigned. Please activate the SysConfig option SetPriorityFromCriticalityAndImpactMatrix to set the priority in the next step based an Criticality and Impact.

Ticket::EventModulePost###9800-SetPriorityFromCriticalityAndImpactMatrix
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Event module registration. Currently, the criticality of the service can also be set in the service, but this has no effect. Therefore, this event module has been implemented that automatically updates the priority regarding Criticality and Impact in a ticket.

Frontend::Base::DynamicFieldScreens
------------------------------------------------------------------------------------------------------------------------------

DynamicFieldScreens###ServiceCatalog
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This configuration defines all possible screens to enable or disable dynamic fields.

Frontend::Customer::ModuleRegistration
------------------------------------------------------------------------------------------------------------------------------

CustomerFrontend::Module###CustomerTileServiceCatalog
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Frontend module registration for the customer interface.

Frontend::Customer::ModuleRegistration::Loader
------------------------------------------------------------------------------------------------------------------------------

Loader::Module::CustomerDashboard###003-CustomerDashboard
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Loader module registration for the customer interface.

Frontend::Customer::View::Dashboard::Configuration
------------------------------------------------------------------------------------------------------------------------------

CustomerDashboard::Configuration::ServiceCatalog
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Additional settings for the service catalog.

CustomerDashboard::Configuration::ServiceCatalog###SortByTicketType
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Show services with the following ticket type last.

CustomerDashboard::Configuration::ServiceCatalog###FAQDescriptionField
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The FAQ field that should be used as the description of an FAQ article in the sidebar (e.g. Field1, Field2, Field3...).

CustomerDashboard::Configuration::ServiceCatalog###DynamicField
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Dynamic fields shown in the service catalog screen of the customer interface.

Frontend::Customer::View::Dashboard::Tiles
------------------------------------------------------------------------------------------------------------------------------

CustomerDashboard::Tiles###ServiceCatalog-01
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Tile registration for the CustomerDashboard. Module is required.

CustomerDashboard::Tiles###FeaturedLink-01
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Tile registration for the CustomerDashboard. Module is required.

About
=======

Contact
-------
| Rother OSS GmbH
| Email: hello@otobo.de
| Web: https://otobo.de

Version
-------
Author: |doc-vendor| / Version: |doc-version| / Date of release: |doc-datestamp|
