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
OTOBO 10.1.x

Packages
--------


Third-party software
--------------------
\-

Configuration Reference
=======================

Core::DynamicFields::ObjectTypeRegistration
------------------------------------------------------------------------------------------------------------------------------

DynamicFields::ObjectType###Service
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
DynamicField object registration.

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

CustomerDashboard::Configuration::ServiceCatalog###DynamicField
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Dynamic fields shown in the service catalog screen of the customer interface.

CustomerDashboard::Configuration::ServiceCatalog###FAQDescriptionField
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The FAQ field that should be used as the description of an FAQ article in the sidebar (e.g. Field1, Field2, Field3...).

CustomerDashboard::Configuration::ServiceCatalog###SortByTicketType
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Show services with the following ticket type last.

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
                                                                                                                                                                                                       99,1          Bot
