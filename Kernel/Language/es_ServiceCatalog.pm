# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.de/
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

package Kernel::Language::es_ServiceCatalog;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: General
    $Self->{Translation}->{'All'} = 'Todo';
    $Self->{Translation}->{'Details'} = 'Detalles';
    $Self->{Translation}->{'Find the right service for your ticket'} = 'Encuentre el servicio apropiado para crear su ticket';

    # Template: TileServiceCatalog
    $Self->{Translation}->{'Show details of this service.'} = 'Mostrar detalles de este servicio.';
    $Self->{Translation}->{'Description not available.'} = 'Descripción no disponible.';
    $Self->{Translation}->{'Search catalog'} = 'Buscar ... (puede usar palabras clave para encontrar el servicio)';

    # Template: AdminService
    $Self->{Translation}->{'Service depends on the following ticket types'} = 'El servicio depende de los siguientes tipos de ticket';
    $Self->{Translation}->{'Ticket destination queue'} = 'Cola del Ticket';
    $Self->{Translation}->{'Customer default service'} = 'Servicio por defecto del Cliente';
    $Self->{Translation}->{'Criticality'} = 'Criticidad';
    $Self->{Translation}->{'Option Reference'} = 'Referencia de Opciones';
    $Self->{Translation}->{'You can use the following options'} = 'Puede usar las siguientes opciones';
    $Self->{Translation}->{'Show services for the following ticket types'} = 'Mostrar servicios de los siguientes tipos de ticket';
    $Self->{Translation}->{'Service descriptions (short & long) specified by User Language.'} = 'Descripción del servicio (corta & larga) especificada por el Idioma del Usuario.';

    $Self->{Translation}->{'Service Description'} = 'Descripción del Servicio';
    $Self->{Translation}->{'Keywords'} = 'Palabras clave';
    $Self->{Translation}->{'Add new service description language'} = 'Agregar nuevo lenguaje de descripción del servicio';


    $Self->{Translation}->{'Within the ServiceCatalogue tile in the customer dashboard, it is possible to show ticket types for preconfigured ticket creation inside the service description. Furthermore, it is possible to restrict the services for other screens using the ticket types set here. If you wish to do this, please activate the options "ServiceCatalog::CreateTypeServiceRelatedAcls" and "ServiceCatalog::CreateTypeServiceRelatedAcls::Options" in the OTOBO system configuration. The restriction is made via automatically generated ACLs, which can be viewed under "Admin -> Access Control Lists (ACL)". If necessary, please adjust the option "ServiceCatalog::CreateTypeServiceRelatedAcls::Options" according to your requirements.'} =
        'Dentro del Catálogo de servicios en el panel del cliente, es posible mostrar tipos de tickets para la creación de tickets preconfigurados dentro de la descripción del servicio. Además, es posible restringir los servicios para otras pantallas utilizando los tipos de entradas aquí configuradas. Si desea hacer esto, active las opciones "ServiceCatalog::CreateTypeServiceRelatedAcls" y "ServiceCatalog::CreateTypeServiceRelatedAcls::Options" en la configuración del sistema de OTOBO. La restricción se realiza mediante ACL generadas automáticamente, que se pueden ver en "Admin -> Listas de control de acceso (ACL)". Si es necesario, ajuste la opción "ServiceCatalog::CreateTypeServiceRelatedAcls::Options" según sus requerimientos.';
    $Self->{Translation}->{'If we work service-based, we do not want to offer the customer a choice of queues in the customer portal when creating a ticket, but decide on the basis of the service into which queue (or which team of agents) the ticket should be processed first. In order to use this option sensibly, please deactivate the option "Ticket::Frontend::CustomerTicketMessage###Queue" and set a sensible default queue in the option "Ticket::Frontend::CustomerTicketMessage###QueueDefault". As soon as you set a "Ticket destination queue" here in the service, the ticket will immediately be created in this queue. If the field remains empty, the default queue configured above will be used.'} =
        'Si trabajamos en función del servicio, y no queremos ofrecer al cliente la posibilidad de elegir entre colas en el portal del cliente al crear un ticket, sino decidir, en función del servicio, en qué cola (o en qué equipo de agentes) debe colocarse el ticket para procesarse primero. Para utilizar esta opción de forma adecuada, desactive la opción "Ticket::Frontend::CustomerTicketMessage###Queue" y establezca una cola predeterminada en la opción "Ticket::Frontend::CustomerTicketMessage###QueueDefault". Tan pronto como establezca una "cola de destino del ticket" aquí en el servicio, el ticket se creará inmediatamente en esta cola. Si el campo permanece vacío, se utilizará la cola predeterminada configurada anteriormente.';
    $Self->{Translation}->{'If you do not assign services to customers or companies individually, but all services are initially offered to your customers for selection, the step of releasing each service as a "default" service under "Admin -> Customer user <-> Service" (or "Customer <-> Service") can be bypassed here. Of course, in the next step it is possible to restrict the services via ACLs.'} =
        'Si no asigna servicios a clientes o empresas individualmente, pero todos los servicios se ofrecen inicialmente a sus clientes para su selección, el paso de publicar cada servicio como un servicio "predeterminado" en "Administrador -> Usuario del cliente <-> Servicio" (o en "Servicio al cliente <->") se puede omitir aqui. Por supuesto, en el siguiente paso es posible restringir los servicios mediante ACL.';
    $Self->{Translation}->{'Here, there is the possibility to automatically calculate the correct ticket priority in the background based on the dynamic field "ITSMCriticality" and "ITSMImpact". Please activate the option "Ticket::EventModulePost###9700-SetDynamicFieldCriticalityFromService" and the option "Ticket::EventModulePost###9800-SetPriorityFromCriticalityAndImpactMatrix". In the next step, you have the possibility using "Admin -> Criticality ↔ Impact ↔ Priority" to set the priority using a matrix.'} =
        'Aquí existe la posibilidad de calcular automáticamente la prioridad correcta del ticket en segundo plano basándose en el campo dinámico "ITSMCriticality" y "ITSMImpact". Active la opción "Ticket::EventModulePost###9700-SetDynamicFieldCriticalityFromService" y la opción "Ticket::EventModulePost###9800-SetPriorityFromCriticalityAndImpactMatrix". En el siguiente paso, tiene la posibilidad de utilizar "Admin -> Criticidad ↔ Impacto ↔ Prioridad" para establecer la prioridad mediante una matriz.';
    $Self->{Translation}->{'Short summary of the service, mainly used in the CustomerDashboard.'} =
        'Descripción corta del servicio, utilizada principalmente en el panel del cliente.';
    
    $Self->{Translation}->{'Keywords to facilitate the search for services within the service catalog.'} = 'Palabras clave para facilitar la búsqueda de servicios dentro del catálogo de servicios.';
    $Self->{Translation}->{'Description (long)'} = 'Descripción (larga)';
    $Self->{Translation}->{'Description of the service. Screenshots and tables are also allowed. Please ensure the correct width of the image for screenshots. This can be adjusted in the ckeditor after uploading the screenshot. A width of 600px has proven to be useful or you can configure a "max-width" of 95% under Advanced.'} =
        'Descripción detallada del servicio. También se permiten capturas de pantalla y tablas. Asegúrese de que la imagen tenga el ancho correcto para las capturas de pantalla. Esto se puede ajustar en el ckeditor después de cargar la captura de pantalla. Un ancho de 600 px ha demostrado ser útil o puede configurar un "ancho máximo" del 95% en Avanzado.';
    $Self->{Translation}->{'Add more service catalog fields'} = 'Agregar más campos al catálogo de servicios';
    $Self->{Translation}->{'You have the option of adding further fields here in the service catalogue at any time. To do this, please go to "Admin -> DynamicFields" and create the new field of the object type "Service". You can then activate the field for the customer dashboard under "Admin -> DynamicField Screens" by assigning it under "CustomerDashboardTile ServiceCatalog".'} =
        'Tiene la opción de agregar más campos aquí en el catálogo de servicios en cualquier momento. Para hacer esto, vaya a "Admin -> DynamicFields" y cree el nuevo campo del tipo de objeto "Servicio". Luego puede activar el campo para el panel del cliente en "Admin -> Pantallas de campo dinámico" asignándolo en "CustomerDashboardTile ServiceCatalog".';

    # Template: AgentITSMSLAZoom
    $Self->{Translation}->{'SLA Information'} = 'Información del SLA';
    $Self->{Translation}->{'Last changed'} = 'Modificado';
    $Self->{Translation}->{'Last changed by'} = 'Modificado por';
    $Self->{Translation}->{'Minimum Time Between Incidents'} = 'Tiempo mínimo entre Incidentes';
    $Self->{Translation}->{'Associated Services'} = 'Servicios Asociados';

    # Template: AgentITSMServiceZoom
    $Self->{Translation}->{'Service Information'} = 'Información del Servicio';
    $Self->{Translation}->{'Current incident state'} = 'Estado actual del Incidente';
    $Self->{Translation}->{'Associated SLAs'} = 'SLAs Asociados';

    # JS Template: TileServiceCatalogContainer
    $Self->{Translation}->{'Create a new ticket for this service.'} = 'Crear nuevo ticket para este servicio.';
    $Self->{Translation}->{'Create %s'} = 'Crear %s';
    $Self->{Translation}->{'Show %s sub-service(s)'} = 'Mostrar %s sub-servicio(s)';
    $Self->{Translation}->{'More details'} = 'Mas detalles';
    $Self->{Translation}->{'Sub-Service(s)'} = 'Sub-servicio(s)';

    # JS Template: TileServiceCatalogDetailed
    $Self->{Translation}->{'sub-service(s) available'} = 'Sub-servicio(s) disponibles';
    $Self->{Translation}->{'Create a new ticket of type %s.'} = 'Crear un nuevo ticket de tipo %s.';
    $Self->{Translation}->{'FAQ article on this topic'} = 'Articulo del FAQ relacionado';
    $Self->{Translation}->{'Additional information'} = 'Información Adicional';
    $Self->{Translation}->{'No additional data are available.'} = 'No hay información adicional disponible.';
    $Self->{Translation}->{'Service hours'} = 'Horario del Servicio';
    $Self->{Translation}->{'o\'clock'} = 'en punto';
    $Self->{Translation}->{'Further information'} = 'Más información';

    # Perl Module: Kernel/Modules/CustomerTileServiceCatalog.pm

    # Perl Module: Kernel/Modules/AgentITSMServiceZoom.pm
    $Self->{Translation}->{'No ServiceID is given!'} = 'No se suministro un ID del Servicio!';
    $Self->{Translation}->{'ServiceID %s not found in database!'} = 'ServiceID "%s" no encontrado!';
    $Self->{Translation}->{'operational'} = 'operacional';
    $Self->{Translation}->{'warning'} = 'advertencia';
    $Self->{Translation}->{'incident'} = 'incidente';

    # JS File: Core.Customer.TileServiceCatalog
    $Self->{Translation}->{'Results for %s'} = 'Resultados para %s';
    $Self->{Translation}->{'Results'} = 'Resultados';

    # SysConfig
    $Self->{Translation}->{'This option makes it possible to preconfigure the automatically generated ACL\'s. The aim is to only display the services that have also been assigned to the service in the service catalogue. To use this function, please first enable the "ServiceCatalog::CreateTypeServiceRelatedAcls" option. "GenerateInitalACLToDisableAllServices" generates an ACL that initially hides all services. The value "Possible" or "PossibleAdd" can be set for the key "ConfigChange". The "DeployNewACL" key decides whether the changed ACL should also be deployed immediately. "ACLValidID" (1, 2, 3) sets the ACL\'s to valid, invalid or temporarily invalid.'} =
        'Esta opción permite preconfigurar las ACL generadas automáticamente. El objetivo es mostrar únicamente los servicios que también han sido asignados al servicio en el catálogo de servicios. Para utilizar esta función, primero habilite la opción "ServiceCatalog::CreateTypeServiceRelatedAcls". "GenerateInitalACLToDisableAllServices" genera una ACL que inicialmente oculta todos los servicios. Para la clave "ConfigChange" se puede establecer el valor "Posible" o "PossibleAdd". La clave "DeployNewACL" decide si la ACL modificada también debe implementarse inmediatamente. "ACLValidID" (1, 2, 3) establece las ACL como válidas, no válidas o temporalmente no válidas.';
    
    $Self->{Translation}->{'Additional settings for the service catalog.'} = 'Configuraciones adicionales para el catálogo de servicios.';
    $Self->{Translation}->{'Both'} = 'Ambos';
    $Self->{Translation}->{'Comment 2'} = 'Comentario 2';
    $Self->{Translation}->{'Dynamic fields shown in the service catalog screen of the customer interface.'} =
        'Campos dinámicos mostrados en el catálogo de servicios de la interfaz del cliente.';

    $Self->{Translation}->{'Event module registration. Currently, the criticality of the service can also be set in the service, but this has no effect. Therefore, this event module has been implemented that automatically updates the DynamicField Criticality in a ticket as soon as a service has been assigned. Please activate the SysConfig option SetPriorityFromCriticalityAndImpactMatrix to set the priority in the next step based an Criticality and Impact.'} =
        'Registro del módulo de eventos. Actualmente, la criticidad del servicio también se puede establecer en el servicio, pero esto no tiene ningún efecto. Por lo tanto, se ha implementado este módulo de eventos que actualiza automáticamente la Criticidad del Campo Dinámico en un ticket tan pronto como se asigna un servicio. Active la opción SysConfig SetPriorityFromCriticalityAndImpactMatrix para establecer la prioridad en el siguiente paso según la criticidad y el impacto.';
    $Self->{Translation}->{'Event module registration. Currently, the criticality of the service can also be set in the service, but this has no effect. Therefore, this event module has been implemented that automatically updates the priority regarding Criticality and Impact in a ticket.'} =
        'Registro del módulo de eventos. Actualmente, la criticidad del servicio también se puede establecer en el servicio, pero esto no tiene ningún efecto. Por lo tanto, se ha implementado este módulo de eventos que actualiza automáticamente la prioridad en cuanto a Criticidad e Impacto en un ticket.';
    $Self->{Translation}->{'Frontend module registration for the AdminGeneralCatalog configuration in the admin area.'} =
        'Registro del módulo frontend para la configuración de AdminGeneralCatalog en el área de administración.';   
    $Self->{Translation}->{'Frontend module registration for the AdminITSMCIPAllocate configuration in the admin area.'} =
        'Registro del módulo frontend para AdminITSMCIPAloque la configuración en el área de administración.';
    $Self->{Translation}->{'Frontend module registration for the AgentITSMSLA object in the agent interface.'} =
        'Registro del módulo frontend para el objeto AgentITSMSLA en la interfaz del agente.';
    $Self->{Translation}->{'Frontend module registration for the AgentITSMSLAPrint object in the agent interface.'} =
        'Registro del módulo frontend para el objeto AgentITSMSLAPrint en la interfaz del agente.';
    $Self->{Translation}->{'Frontend module registration for the AgentITSMSLAZoom object in the agent interface.'} =
        'Registro del módulo frontend para el objeto AgentITSMSLAZoom en la interfaz del agente.';
    $Self->{Translation}->{'Frontend module registration for the AgentITSMService object in the agent interface.'} =
        'Registro del módulo frontend para el objeto AgentITSMService en la interfaz del agente.';
    $Self->{Translation}->{'Frontend module registration for the AgentITSMServicePrint object in the agent interface.'} =
        'Registro del módulo frontend para el objeto AgentITSMServicePrint en la interfaz del agente.';
    $Self->{Translation}->{'Frontend module registration for the AgentITSMServiceZoom object in the agent interface.'} =
        'Registro del módulo frontend para el objeto AgentITSMServiceZoom en la interfaz del agente.';

    $Self->{Translation}->{'General Catalog'} = 'Catálogo General';
    $Self->{Translation}->{'ITSM SLA Overview.'} = 'Resumen ITSM SLA.';
    $Self->{Translation}->{'ITSM Service Overview.'} = 'Resumen ITSM Servicios.';
    $Self->{Translation}->{'Incident'} = 'Incident';
    $Self->{Translation}->{'Incident State Type'} = 'Tipo de estado del Incidente';
    $Self->{Translation}->{'Includes'} = 'Incluye';
    $Self->{Translation}->{'Manage priority matrix.'} = 'Aministrar la matriz de prioridad';
    $Self->{Translation}->{'Manage the criticality - impact - priority matrix.'} = 'Administrar la criticidad - impacto - prioridad';
    $Self->{Translation}->{'Module to show the Back menu item in SLA menu.'} = 'Módulo para motrar el botón Volver en el menú del SLA.';
    $Self->{Translation}->{'Module to show the Back menu item in service menu.'} = 'Módulo para motrar el botón Volver en el menú del Servicio.';
    $Self->{Translation}->{'Module to show the Link menu item in service menu.'} = 'Módulo para motrar el botón Vincular en el menú del SLA.';
    $Self->{Translation}->{'Module to show the Print menu item in SLA menu.'} = 'Módulo para motrar el botón Imprimir en el menú del SLA.';
    $Self->{Translation}->{'Module to show the Print menu item in service menu.'} = 'Módulo para motrar el botón Imprimir en el menú del Servicio.';
    $Self->{Translation}->{'Operational'} = 'Operacional';
    $Self->{Translation}->{'Parameters for the example comment 2 of the general catalog attributes.'} =
        'Parámetros para el ejemplo comentario 2 de los atributos del catálogo general.';
    $Self->{Translation}->{'Parameters for the example permission groups of the general catalog attributes.'} =
        'Parámetros para los grupos de permisos de ejemplo de los atributos del catálogo general.';
    $Self->{Translation}->{'Parameters for the incident states in the preference view.'} = 'Parámetros para los estados del incidente en la vista de preferencias.';

    $Self->{Translation}->{'Part of'} = 'Parte de';
    $Self->{Translation}->{'Permission Group'} = 'Permisos de Grupo';
    $Self->{Translation}->{'Relevant to'} = 'Relevante a';
    $Self->{Translation}->{'Required for'} = 'Requerido para';
    $Self->{Translation}->{'SLA Overview'} = 'Resumen de SLA';
    $Self->{Translation}->{'SLA Print.'} = 'Imprimrir SLA.';
    $Self->{Translation}->{'SLA Zoom.'} = 'Visualizar SLA.';
    $Self->{Translation}->{'Service Overview'} = 'Resumen del Servicio';
    $Self->{Translation}->{'Service Print.'} = 'Imprimir Servicio.';
    $Self->{Translation}->{'Service Zoom.'} = 'Visualizar Servicio';
    $Self->{Translation}->{'Service-Area'} = 'Servicio-Area';
    $Self->{Translation}->{'Set the type and direction of links to be used to calculate the incident state. The key is the name of the link type (as defined in LinkObject::Type), and the value is the direction of the IncidentLinkType that should be followed to calculate the incident state. For example if the IncidentLinkType is set to \'DependsOn\', and the Direction is \'Source\', only \'Depends on\' links will be followed (and not the opposite link \'Required for\') to calculate the incident state. You can add more link types ad directions as you like, e.g. \'Includes\' with the direction \'Target\'. All link types defined in the sysconfig options LinkObject::Type are possible and the direction can be \'Source\', \'Target\', or \'Both\'. IMPORTANT: AFTER YOU MAKE CHANGES TO THIS SYSCONFIG OPTION YOU NEED TO RUN THE CONSOLE COMMAND bin/otobo.Console.pl Admin::ITSM::IncidentState::Recalculate SO THAT ALL INCIDENT STATES WILL BE RECALCULATED BASED ON THE NEW SETTINGS!'} =
        'Establezca el tipo y la dirección de los enlaces que se utilizarán para calcular el estado del incidente. La clave es el nombre del tipo de vínculo (como se define en LinkObject::Type) y el valor es la dirección del IncidentLinkType que se debe seguir para calcular el estado del incidente. Por ejemplo, si IncidentLinkType está establecido en \'DependsOn\' y la dirección es \'Source\', solo se seguirán los enlaces \'Depends on\' (y no el enlace opuesto \'Requerido para\') para calcular el estado del incidente. Puede agregar más tipos de enlaces de direcciones de anuncios según lo desee, p. \'Incluye\' con la dirección \'Destino\'. Todos los tipos de vínculo definidos en las opciones de sysconfig LinkObject::Type son posibles y la dirección puede ser \'Fuente\', \'Destino\' o \'Ambos\'. IMPORTANTE: DESPUÉS DE REALIZAR CAMBIOS EN ESTA OPCIÓN SYSCONFIG, DEBE EJECUTAR EL COMANDO DE CONSOLA bin/otobo.Console.pl Admin::ITSM::IncidentState::Recalculate PARA QUE TODOS LOS ESTADOS DEL INCIDENTE SE RECALCULEN EN FUNCIÓN DE LAS NUEVAS CONFIGURACIONES.';
    $Self->{Translation}->{'Show services with the following ticket type last.'} = 'Mostrar servicios con el siguiente tipo de entrada al final.';
    $Self->{Translation}->{'Source'} = 'Origen';
    $Self->{Translation}->{'The FAQ field that should be used as the description of an FAQ article in the sidebar (e.g. Field1, Field2, Field3...).'} =
        'El campo de preguntas frecuentes que debe usarse como descripción de un artículo de preguntas frecuentes en la barra lateral (por ejemplo, Campo1, Campo2, Campo3...).';

    $Self->{Translation}->{'This option allows you to automatically generate ACLs for different interfaces when creating services. Services will then only be displayed if the ticket type stored in the service has been selected. The "AddBulkACL" console script can also be used to create ACLs for services that have already been created.'} =
        'Esta opción le permite generar automáticamente ACL para diferentes interfaces al crear servicios. Los servicios solo se mostrarán si se ha seleccionado el tipo de ticket almacenado en el servicio. El script de consola "AddBulkACL" también se puede utilizar para crear ACL para servicios que ya se han creado.';

    push @{ $Self->{JavaScriptStrings} // [] }, (
        'Results',
        'Results for %s',
        'Additional information',
        'No additional data are available.',
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
        'Search catalog',
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
