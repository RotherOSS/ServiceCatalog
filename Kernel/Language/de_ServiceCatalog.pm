# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2021 Rother OSS GmbH, https://otobo.de/
# --
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
# --

package Kernel::Language::de_ServiceCatalog;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: TileServiceCatalog
    $Self->{Translation}->{'Show details of this service.'} = 'Details zu diesem Service anzeigen.';

    # Template: AdminService
    $Self->{Translation}->{'Service depends on the following ticket types'} = 'Service ist abhängig von folgenden Ticket-Typen';
    $Self->{Translation}->{'Ticket destination queue'} = 'Ticket Ziel-Queue';
    $Self->{Translation}->{'Customer default service'} = 'Kundenbenutzer Standard-Service';
    $Self->{Translation}->{'Criticality'} = 'Kritikalität';
    $Self->{Translation}->{'Option Reference'} = 'Dokumentation der Optionen';
    $Self->{Translation}->{'You can use the following options'} = 'Sie können folgende Optionen verwenden';
    $Self->{Translation}->{'Show services for the following ticket types'} = 'Services für die folgenden Tickettypen anzeigen';
    $Self->{Translation}->{'Within the ServiceCatalogue tile in the customer dashboard, it is possible to show ticket types for preconfigured ticket creation inside the service description. Furthermore, it is possible to restrict the services for other screens using the ticket types set here. If you wish to do this, please activate the options "ServiceCatalog::CreateTypeServiceRelatedAcls" and "ServiceCatalog::CreateTypeServiceRelatedAcls::Options" in the OTOBO system configuration. The restriction is made via automatically generated ACLs, which can be viewed under "Admin -> Access Control Lists (ACL)". If necessary, please adjust the option "ServiceCatalog::CreateTypeServiceRelatedAcls::Options" according to your requirements.'} =
        'Innerhalb der Kachel ServiceCatalog im KundenDashboard existiert in der Servicebeschreibung die Möglichkeit, Ticket-Typen zur vorkonfigurierten Ticket-Erstellung einzublenden. Weiterhin besteht die Möglichkeit, auch für andere Masken die Services anhand der hier gesetzten Ticket-Typen einzuschränken. Falls Sie dies wünschen, aktivieren Sie bitte die Optionen "ServiceCatalog::CreateTypeServiceRelatedAcls" und "ServiceCatalog::CreateTypeServiceRelatedAcls::Options" in der OTOBO Systemkonfiguration. Die Einsschränkung wird über automatisch generierte ACL’s vorgenommen, diese können unter "Admin -> Access Control Lists (ACL)" eingesehen werden. Bitte passen Sie bei Bedarf die Option "ServiceCatalog::CreateTypeServiceRelatedAcls::Options" nach Ihren Anforderungen an.';
    $Self->{Translation}->{'If we work service-based, we do not want to offer the customer a choice of queues in the customer portal when creating a ticket, but decide on the basis of the service into which queue (or which team of agents) the ticket should be processed first. In order to use this option sensibly, please deactivate the option "Ticket::Frontend::CustomerTicketMessage###Queue" and set a sensible default queue in the option "Ticket::Frontend::CustomerTicketMessage###QueueDefault". As soon as you set a "Ticket destination queue" here in the service, the ticket will immediately be created in this queue. If the field remains empty, the default queue configured above will be used.'} =
        'Wenn wir Servicebasierend arbeiten, wollen wir den Kunden im Kundenportal bei der Ticketerstellung nicht die Queue zur Auswahl stellen, sondern anhand des Services entscheiden, in welche Queue (bzw. welches Bearbeiter-Team) das Ticket zuerst bearbeiten soll. Um diese Option sinnvoll zu nutzen, deaktivieren Sie bitte die Option "Ticket::Frontend::CustomerTicketMessage###Queue" und setzen Sie in der Option "Ticket::Frontend::CustomerTicketMessage###QueueDefault" eine sinnvolle Standard-Queue. Sobald Sie nun hier im Service eine "Ticket destination queue" setzen, wird das Ticket sofort in dieser Queue erstellt. Wenn das Feld leer bleibt, wird die oben konfigurierte Standardqueue verwendet.';
    $Self->{Translation}->{'If you do not assign services to customers or companies individually, but all services are initially offered to your customers for selection, the step of releasing each service as a "default" service under "Admin -> Customer user <-> Service" (or "Customer <-> Service") can be bypassed here. Of course, in the next step it is possible to restrict the services via ACLs.'} =
        'Falls Sie Services nicht Kunden- oder Firmen einzeln zuordnen, sondern alle Services initial Ihren Kunden zur Auswahl angeboten werden, kann hier der Schritt umgangen werden, jeden Service noch unter "Admin -> Kundenbenutzer <-> Service" (oder "Kunden <-> Service") als "Default" Service freizugeben. Selbstverständlich ist es im nächsten Schritt möglich, die Services noch über ACL’s einzuschränken.';
    $Self->{Translation}->{'Here, there is the possibility to automatically calculate the correct ticket priority in the background based on the dynamic field "ITSMCriticality" and "ITSMImpact". Please activate the option "Ticket::EventModulePost###9700-SetDynamicFieldCriticalityFromService" and the option "Ticket::EventModulePost###9800-SetPriorityFromCriticalityAndImpactMatrix". In the next step, you have the possibility using "Admin -> Criticality ↔ Impact ↔ Priority" to set the priority using a matrix.'} =
        'Hier existiert die Möglichkeit, aufgrund des Dynamischen Feldes "ITSMCriticality" und "ITSMImpact" im Hintergrund automatisch die richtige Ticket-Priorität zu berechnen. Bitte aktivieren Sie hierzu die Option "Ticket::EventModulePost###9700-SetDynamicFieldCriticalityFromService" und die Option "Ticket::EventModulePost###9800-SetPriorityFromCriticalityAndImpactMatrix". Im nächsten Schritt haben Sie unter "Admin -> Criticality ↔ Impact ↔ Priority" die Möglichkeit, die Priorität anhand einer Matrix festzulegen.';
    $Self->{Translation}->{'Short summary of the service, mainly used in the CustomerDashboard.'} =
        'Kurze Zusammenfassung des Services, wird vor allem im CustomerDashboard verwendet.';
    $Self->{Translation}->{'Description (long)'} = 'Beschreibung';
    $Self->{Translation}->{'Description of the service. Screenshots and tables are also allowed. Please ensure the correct width of the image for screenshots. This can be adjusted in the ckeditor after uploading the screenshot. A width of 600px has proven to be useful or you can configure a "max-width" of 95% under Advanced.'} =
        'Beschreibung des Services. Auch Screenshots und Tabellen sind erlaubt. Bitte achten Sie bei Screenshots auf die richtige Breite des Bildes. Diese kann im ckeditor nach dem Upload des Screenshots angepasst werden. Bewährt hat sich eine Breite von 600px oder Sie konfigurien unter Advanced eine "max-width" von 95%.';
    $Self->{Translation}->{'Add more service catalog fields'} = 'Weitere Servicekatalog Felder hinzufügen';
    $Self->{Translation}->{'You have the option of adding further fields here in the service catalogue at any time. To do this, please go to "Admin -> DynamicFields" and create the new field of the object type "Service". You can then activate the field for the customer dashboard under "Admin -> DynamicField Screens" by assigning it under "CustomerDashboardTile ServiceCatalog".'} =
        'Sie haben jederzeit die Möglichkeit, weitere Felder hier im Servicekatalog hinzuzufügen. Hierzu gehen Sie bitte unter "Admin -> DynamicFields" und legen das neue Feld vom Objekt-Type "Service" an. Anschließend können Sie das Feld unter "Admin -> DynamicField Screens" noch für das Kundendashboard freischalten, indem Sie es unter "CustomerDashboardTile ServiceCatalog" zuordnen.';

    # Template: AgentITSMSLAZoom
    $Self->{Translation}->{'SLA Information'} = 'SLA-Informationen';
    $Self->{Translation}->{'Last changed'} = 'Zuletzt geändert';
    $Self->{Translation}->{'Last changed by'} = 'Zuletzt geändert von';
    $Self->{Translation}->{'Minimum Time Between Incidents'} = 'Minimale Zeit zwischen den Vorfällen';
    $Self->{Translation}->{'Associated Services'} = 'Zugehörige Services';

    # Template: AgentITSMServiceZoom
    $Self->{Translation}->{'Service Information'} = 'Service-Informationen';
    $Self->{Translation}->{'Current incident state'} = 'Aktueller Vorfallstatus';
    $Self->{Translation}->{'Associated SLAs'} = 'Zugehörige SLAs';

    # JS Template: TileServiceCatalogContainer
    $Self->{Translation}->{'Create a new ticket for this service.'} = 'Ein neues Ticket basierend auf diesem Service erstellen.';
    $Self->{Translation}->{'Create %s'} = 'Erstelle %s';
    $Self->{Translation}->{'Show %s sub-service(s)'} = 'Zeige %s Unterservice(s)';
    $Self->{Translation}->{'More details'} = 'Mehr Details';
    $Self->{Translation}->{'Sub-Service(s)'} = 'Unterservice(s)';

    # JS Template: TileServiceCatalogDetailed
    $Self->{Translation}->{'sub-service(s) available'} = 'Unterservice(s) vorhanden';
    $Self->{Translation}->{'Create a new ticket of type %s.'} = 'Ein neues Ticket des Typen %s erstellen.';
    $Self->{Translation}->{'FAQ article on this topic'} = 'FAQ-Artikel zu diesem Thema';
    $Self->{Translation}->{'Additional information'} = 'Zusatzinformationen';
    $Self->{Translation}->{'Service hours'} = 'Servicezeiten';
    $Self->{Translation}->{'o\'clock'} = 'Uhr';
    $Self->{Translation}->{'Further information'} = 'Weitere Informationen';

    # Perl Module: Kernel/Modules/CustomerTileServiceCatalog.pm

    # Perl Module: Kernel/Modules/AgentITSMServiceZoom.pm
    $Self->{Translation}->{'No ServiceID is given!'} = 'Keine ServiceID vorhanden!';
    $Self->{Translation}->{'ServiceID %s not found in database!'} = 'ServiceID "%s" in der Datenbank nicht gefunden!';
    $Self->{Translation}->{'operational'} = 'Operativ';
    $Self->{Translation}->{'warning'} = 'Warnung';
    $Self->{Translation}->{'incident'} = 'Vorfall';

    # JS File: Core.Customer.TileServiceCatalog
    $Self->{Translation}->{'results for %s'} = 'Ergebnisse für %s';
    $Self->{Translation}->{'results'} = 'Ergebnisse';

    # SysConfig
    $Self->{Translation}->{'This option makes it possible to preconfigure the automatically generated ACL\'s. The aim is to only display the services that have also been assigned to the service in the service catalogue. To use this function, please first enable the "ServiceCatalog::CreateTypeServiceRelatedAcls" option. "GenerateInitalACLToDisableAllServices" generates an ACL that initially hides all services. The value "Possible" or "PossibleAdd" can be set for the key "ConfigChange". The "DeployNewACL" key decides whether the changed ACL should also be deployed immediately. "ACLValidID" (1, 2, 3) sets the ACL\'s to valid, invalid or temporarily invalid.'} =
        'Diese Option ermöglicht es die automatisch generierten ACL\'s vorzukonfigurieren. Ziel ist es, lediglich die Services anzuzeigen, die auch im Servicekatalog dem Service zugewiesen wurden. Um diese Funktion zu verwenden, bitte zuerst die Option "ServiceCatalog::CreateTypeServiceRelatedAcls" aktivieren. "GenerateInitalACLToDisableAllServices" generiert eine ACL, die initial alle Services ausblendet. Für den Key "ConfigChange" kann der Wert "Possible" oder "PossibleAdd" gesetzt werden. Der Key "DeployNewACL" entscheidet darüber, ob die geänderte ACL auch sofort deployed werden soll. "ACLValidID" (1, 2, 3) setzt die ACL\’s auf gültig, ungültig oder temporär ungültig.';
    $Self->{Translation}->{'Additional settings for the service catalog.'} = 'Weitere Einstellungen bezüglich dem OTOBO Servicekatalog Feature.';
    $Self->{Translation}->{'Both'} = 'Beide';
    $Self->{Translation}->{'Comment 2'} = 'Kommentar 2';
    $Self->{Translation}->{'Dynamic fields shown in the service catalog screen of the customer interface.'} =
        '';
    $Self->{Translation}->{'Event module registration. Currently, the criticality of the service can also be set in the service, but this has no effect. Therefore, this event module has been implemented that automatically updates the DynamicField Criticality in a ticket as soon as a service has been assigned. Please activate the SysConfig option SetPriorityFromCriticalityAndImpactMatrix to set the priority in the next step based an Criticality and Impact.'} =
        '';
    $Self->{Translation}->{'Event module registration. Currently, the criticality of the service can also be set in the service, but this has no effect. Therefore, this event module has been implemented that automatically updates the priority regarding Criticality and Impact in a ticket.'} =
        '';
    $Self->{Translation}->{'Frontend module registration for the AdminGeneralCatalog configuration in the admin area.'} =
        'Registrierung des Frontend-Moduls für die Konfiguration von AdminGeneralCatalog im Admin-Bereich.';
    $Self->{Translation}->{'Frontend module registration for the AdminITSMCIPAllocate configuration in the admin area.'} =
        'Frontend-Modulregistrierung der AdminITSMCIPAllocate Konfiguration im Admin-Bereich.';
    $Self->{Translation}->{'Frontend module registration for the AgentITSMSLA object in the agent interface.'} =
        'Frontend-Modulregistrierung des AgentITSMSLA-Objekts im Agent-Interface.';
    $Self->{Translation}->{'Frontend module registration for the AgentITSMSLAPrint object in the agent interface.'} =
        'Frontend-Modulregistrierung des AgentITSMSLAPrint-Objekts im Agent-Interface.';
    $Self->{Translation}->{'Frontend module registration for the AgentITSMSLAZoom object in the agent interface.'} =
        'Frontend-Modulregistrierung des AgentITSMSLAZoom-Objekts im Agent-Interface.';
    $Self->{Translation}->{'Frontend module registration for the AgentITSMService object in the agent interface.'} =
        'Frontend-Modulregistrierung des AgentITSMService-Objekts im Agent-Interface.';
    $Self->{Translation}->{'Frontend module registration for the AgentITSMServicePrint object in the agent interface.'} =
        'Frontend-Modulregistrierung des AgentITSMServicePrint-Objekts im Agent-Interface.';
    $Self->{Translation}->{'Frontend module registration for the AgentITSMServiceZoom object in the agent interface.'} =
        'Frontend-Modulregistrierung des AgentITSMServiceZoom-Objekts im Agent-Interface.';
    $Self->{Translation}->{'General Catalog'} = 'General Katalog';
    $Self->{Translation}->{'ITSM SLA Overview.'} = 'ITSM SLA-Übersicht.';
    $Self->{Translation}->{'ITSM Service Overview.'} = 'ITSM-Services-Übersicht.';
    $Self->{Translation}->{'Incident'} = 'Vorfall';
    $Self->{Translation}->{'Incident State Type'} = 'Vorfallstatus-Typ';
    $Self->{Translation}->{'Includes'} = 'Beinhaltet';
    $Self->{Translation}->{'Manage priority matrix.'} = 'Prioritäts-Matrix verwalten';
    $Self->{Translation}->{'Manage the criticality - impact - priority matrix.'} = 'Kritikalität - Auswirkung - Priorität-Matrix verwalten ';
    $Self->{Translation}->{'Module to show the Back menu item in SLA menu.'} = 'Modul, das den "Zurück"-Menüeintrag im SLA-Menü anzeigt';
    $Self->{Translation}->{'Module to show the Back menu item in service menu.'} = 'Modul, das den "Zurück"-Menüeintrag im Service-Menü anzeigt.';
    $Self->{Translation}->{'Module to show the Link menu item in service menu.'} = 'Modul, dass den "Verküpfen"-Menüeintrag im Service-Menü anzeigt.';
    $Self->{Translation}->{'Module to show the Print menu item in SLA menu.'} = 'Modul, dass den "Ausdrucken"-Menüeintrag im SLA-Menü anzeigt.';
    $Self->{Translation}->{'Module to show the Print menu item in service menu.'} = 'Modul, dass den "Ausdrucken"-Menüeintrag im Service-Menü anzeigt.';
    $Self->{Translation}->{'Operational'} = 'Operativ';
    $Self->{Translation}->{'Parameters for the example comment 2 of the general catalog attributes.'} =
        'Parameter für den Beispiel-Kommentar 2 der General Katalog-Attribute.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parameter für die zugriffsberechtigte Gruppe der General Katalog-Attribute.';
    $Self->{Translation}->{'Parameters for the incident states in the preference view.'} = 'Parameter für den Vorfallsstatus in der Ansicht für die Einstellungen.';
    $Self->{Translation}->{'Part of'} = 'Teil von';
    $Self->{Translation}->{'Permission Group'} = 'Berechtigungsgruppe \*';
    $Self->{Translation}->{'Relevant to'} = 'Relevant für';
    $Self->{Translation}->{'Required for'} = 'Benötigt für';
    $Self->{Translation}->{'SLA Overview'} = 'SLA-Übersicht';
    $Self->{Translation}->{'SLA Print.'} = 'SLA-Audruck.';
    $Self->{Translation}->{'SLA Zoom.'} = 'SLA-Detailansicht.';
    $Self->{Translation}->{'Service Overview'} = 'Service-Übersicht';
    $Self->{Translation}->{'Service Print.'} = 'Service Ausdrucken.';
    $Self->{Translation}->{'Service Zoom.'} = 'Service-Detailansicht';
    $Self->{Translation}->{'Service-Area'} = 'Service-Bereich';
    $Self->{Translation}->{'Set the type and direction of links to be used to calculate the incident state. The key is the name of the link type (as defined in LinkObject::Type), and the value is the direction of the IncidentLinkType that should be followed to calculate the incident state. For example if the IncidentLinkType is set to \'DependsOn\', and the Direction is \'Source\', only \'Depends on\' links will be followed (and not the opposite link \'Required for\') to calculate the incident state. You can add more link types ad directions as you like, e.g. \'Includes\' with the direction \'Target\'. All link types defined in the sysconfig options LinkObject::Type are possible and the direction can be \'Source\', \'Target\', or \'Both\'. IMPORTANT: AFTER YOU MAKE CHANGES TO THIS SYSCONFIG OPTION YOU NEED TO RUN THE CONSOLE COMMAND bin/otobo.Console.pl Admin::ITSM::IncidentState::Recalculate SO THAT ALL INCIDENT STATES WILL BE RECALCULATED BASED ON THE NEW SETTINGS!'} =
        'Setzen des Typs und der Richtung der verwendeten Links, um den Vorfallstatus zu berechnen. Der Schlüssel ist der Name des Link-Typs (wie in LinkObject::Type definiert), und der Wert ist die Richtung des IncidentLinkType, die befolgt werden soll, um den Incident-Status zu berechnen. Zum Beispiel, wenn der IncidentLinkType auf \'DependsOn\' und als Richtung \'Quelle\' gesetzt ist, wird nur \'Depends\' Links gefolgt (und nicht dem Gegenteil \'Benötigt für\') um den IncidentState zu berechnen. Sie können soviele Link-Typen und Richtungen hinzufügen wie Sie möchten, z.B.: \'Enthält\' mit der Richtung \'Target\'. Alle in der Sysconfig unter Linkobject::Type definierten Verknüpfungsarten sind möglich sind und die Richtung kann \'Quelle\', \'Ziel\' oder \'Beide\' sein. WICHTIG: Nachdem Sie Änderungen an dieser Sysconfig-Einstellung gemacht haben, führen Sie das Skript bin/otobo.ITSMConfigItemIncidentStateRecalculate.pl SO aus, damit alle Vorfallstatus anhand der neuen Einstellungen berechnet werden.';
    $Self->{Translation}->{'Show services with the following ticket type last.'} = 'Zeige Services mit folgendem Ticket-Typen als Letztes an.';
    $Self->{Translation}->{'Source'} = 'Sourcen';
    $Self->{Translation}->{'The FAQ field that should be used as the description of an FAQ article in the sidebar (e.g. Field1, Field2, Field3...).'} =
        'FAQ-Feld, das als Beschreibungsfeld auf der rechten Seite im CustomerDashboard Servicekatalog angzeigt werden soll (e.g. Field1, Field2, Field3...).';
    $Self->{Translation}->{'This option allows you to automatically generate ACLs for different interfaces when creating services. Services will then only be displayed if the ticket type stored in the service has been selected. The "AddBulkACL" console script can also be used to create ACLs for services that have already been created.'} =
        'Diese Option erlaubt die automatische Generierung von ACL\'s, die die Anzeige von Services in Abhängigkeit der im Servicekatalog zugewisenen Typen einschränkt. Um ACL\'s für bereits angelegte Services zu erstellen, kann auch das Console-Skript "AddBulkACL\ verwendet werden."';

    push @{ $Self->{JavaScriptStrings} // [] }, (
        'results',
        'results for %s',
        'Additional information',
        'All',
        'Create %s',
        'Create Ticket',
        'Create a new ticket for this service.',
        'Create a new ticket of type %s.',
        'Details',
        'FAQ article on this topic',
        'First Response Time',
        'More details',
        'Search',
        'Service Information',
        'Service hours',
        'Show %s sub-service(s)',
        'Show details of this service.',
        'Show or hide the content',
        'Solution Time',
        'Sub-Service(s)',
        'hour(s)',
        'o\'clock',
        'Further information',
        'sub-service(s) available',
    );

}

1;
