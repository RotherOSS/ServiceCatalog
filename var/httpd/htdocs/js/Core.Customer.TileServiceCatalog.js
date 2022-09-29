// --
// OTOBO is a web-based ticketing system for service organisations.
// --
// Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
// Copyright (C) 2019-2021 Rother OSS GmbH, https://otobo.de/
// --
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.
// --

"use strict";

var Core = Core || {};
Core.Customer = Core.Customer || {};

Core.Customer.TileServiceCatalog = (function (TargetNS) {

    TargetNS.Init = function() {
        // Listen to document to recognize DOM changes.
        $(document).on('click', '.oooServiceIDAvailable', function() {
            var ServiceID = $(this).attr('data-service-id');

            // Show the dialog if not open.
            if (!$('.Dialog.Modal').length) {
                Core.UI.Dialog.ShowDialog({
                    HTML: $('.oooServiceCatalogWrapper').clone(),
                    Title: Core.Language.Translate('Service Catalog'),
                    Modal: true,
                    CloseOnClickOutside: true,
                    CloseOnEscape: true,
                    PositionTop: '15px',
                    PositionLeft: 'Center',
                    AllowAutoGrow: false
                });

                $('.Dialog.Modal .oooServiceCatalog.oooHidden').removeClass('oooHidden');
            }

            TargetNS.DisplayServiceList(ServiceID);
        });

        // Show the detailed view.
        $(document).on('click', '.oooInformation', function() {
            var ServiceID = $(this).parent().attr('data-service-id');
            TargetNS.DisplayDetailedService(ServiceID);
        });

        // Show subservices.
        $(document).on('click', '.Dialog .oooServiceContainer', function(Event) {
            if ($(Event.target).hasClass('ooofo-info') || $(Event.target).hasClass('ooofo-add')) {
                return;
            }
            var ServiceID = $(this).attr('data-service-id');
            TargetNS.DisplayServiceList(ServiceID);
        });
        
        $(document).on('click', '.Dialog span.oooSubservices', function(Event) {
            var ServiceID = $(this).attr('data-service-id');
            TargetNS.DisplayServiceList(ServiceID);
        });
    }

    TargetNS.DisplayServiceList = function(ServiceID) {
        var Subservices = TargetNS.GetAllSubservices(ServiceID);

        // If there is only one subservice, jump straight into that list.
        if (Subservices.length == 1) {
            var Subservice = JSON.parse(Core.Config.Get('ServiceList'))[Subservices];

            // Only jump deeper if the subservice does not have the option to create a ticket for itself.
            if (!Subservice.TicketType) {
                return TargetNS.DisplayServiceList(Subservices[0]);
            }
        // If there is no subservice, show a detailed view of that service.
        } else if (Subservices.length == 0) {
            return TargetNS.DisplayDetailedService(ServiceID);
        }

        TargetNS.ClearServices();
        for (var SubserviceID of Subservices) {
            TargetNS.DisplayService(SubserviceID);
        }

        TargetNS.CreateBreadcrumb(ServiceID);
    }

    TargetNS.DisplayService = function(ServiceID) {
        var Service = JSON.parse(Core.Config.Get('ServiceList'))[ServiceID];
        var Baselink = Core.Config.Get('Baselink');

        var Container = Core.Template.Render('Customer/TileServiceCatalogContainer', {
            ID: ServiceID,
            Name:  Service.NameShort,
            DescriptionShort: Service.DescriptionShort,
            NumberOfSubservices: TargetNS.GetAllSubservices(ServiceID).length,
            TicketType: Service.TicketType,
            Baselink: Baselink,
            NotSelectable: Service.NotSelectable,
        });

        $(Container).appendTo('.Dialog .oooServiceWrapper');
    }

    TargetNS.DisplayDetailedService = function(ServiceID) {
        TargetNS.ClearServices();
        var Service = JSON.parse(Core.Config.Get('ServiceList'))[ServiceID];
        var Baselink = Core.Config.Get('Baselink');
        var IframeLink = Baselink + 'Action=CustomerTileServiceCatalog;Subaction=HTMLView;ServiceID=' + ServiceID + ';' + Core.Config.Get('SessionName') + '=' + Core.Config.Get('SessionID')

        // Convert minutes to hours and round to the first decimal place.
        var SolutionTime, FirstResponseTime;
        if (Service.SolutionTime && !isNaN(Service.SolutionTime)) {
            SolutionTime = Service.SolutionTime / 60;
            SolutionTime = Math.round(SolutionTime * 10) / 10;
        }

        if (Service.FirstResponseTime && !isNaN(Service.FirstResponseTime)) {
            FirstResponseTime = Service.FirstResponseTime / 60;
            FirstResponseTime = Math.round(FirstResponseTime * 10) / 10;
        }

        var Detailed = Core.Template.Render('Customer/TileServiceCatalogDetailed', {
            ID: ServiceID,
            Name:  Service.NameShort,
            DescriptionShort: Service.DescriptionShort,
            IframeLink: IframeLink,
            WorkingHours: Service.WorkingHours,
            SolutionTime: SolutionTime,
            FirstResponseTime: FirstResponseTime,
            TypeList: Service.TicketType,
            Baselink: Baselink,
            NumberOfSubservices: TargetNS.GetAllSubservices(ServiceID).length,
        });
        
        $(Detailed).appendTo('.Dialog .oooServiceWrapper');

        // Resize iFrame.
        var IFrame = $('.Dialog .oooServiceWrapper').find('[data-service-id="' + ServiceID + '"]').find('iframe');
        ResizeIframe(IFrame);

        TargetNS.CreateBreadcrumb(ServiceID);
    }

    // Empty the wrapping. TODO: Remove as a function?
    TargetNS.ClearServices = function() {
        $('.oooServiceWrapper').html('');
    }

    TargetNS.CreateBreadcrumb = function(ServiceID) {
        var Service = JSON.parse(Core.Config.Get('ServiceList'));
        var SelectedService = Service[ServiceID];

        var LiString = '<li data-service-id="' + SelectedService.ServiceID + '" class="oooServiceIDAvailable">' + SelectedService.NameShort + '</li>';
        // Limit the number of shown parents.
        for (var i = 0; i < 10; i++) {
            var ParentID = SelectedService.ParentID;
            if (!ParentID) break;

            SelectedService = Service[ParentID];
            LiString = '<li data-service-id="' + SelectedService.ServiceID + '" class="oooServiceIDAvailable">' + SelectedService.NameShort + '</li><i class="ooofo ooofo-arrow_r"></i>' + LiString;
        }

        $('.Dialog .oooServiceBreadcrumbField').html('<ul class="oooBreadcrumbServiceList">' + LiString + '</ul>');
    }

    TargetNS.GetAllSubservices = function(ServiceID) {
        var Service = JSON.parse(Core.Config.Get('ServiceList'));

        // Iterate through all services and get all subservices of ServiceID.
        var UnorderedSubservices = {};
        for (var ChildID in Service) {
            if (ServiceID == Service[ChildID].ParentID) {
                UnorderedSubservices[Service[ChildID].NameShort] = ChildID;
            }
        }

        // Order all Subservices by name.
        var Subservices = Object.keys(UnorderedSubservices).sort().reduce(
            function (Obj, Key) {
                Obj[Key] = UnorderedSubservices[Key];
                return Obj;
            }, {}
        );

        
        // Push services of a specific ticket type to the end of the list.
        var TicketTypeFilter = Core.Config.Get('SortByTicketType');
        if (TicketTypeFilter) {
            var SortByTicketType = {};
            $.each( Subservices, function( ServiceName, ServiceID ) {
                // Filter for services with a single ticket type and only match if it's the ticket type we are looking for.
                if (
                    Service[ServiceID].TicketType &&
                    Object.keys(Service[ServiceID].TicketType).length == 1 &&
                    Service[ServiceID].TicketType[TicketTypeFilter]
                    )
                {
                    // Remove the subservice from the main list.
                    delete Subservices[ServiceName];
                    SortByTicketType[ServiceName] = ServiceID;
                }
            });
    
            // Add all removed subservices back to the main list.
            $.extend(Subservices, SortByTicketType);
        }

        return Object.values(Subservices);
    }

    /**
     * @private
     * @name CalculateHeight
     * @memberof Core.Customer.TileServiceCatalog
     * @function
     * @param {DOMObject} Iframe - DOM representation of an iframe
     * @description
     *      Resizes Iframe to its max inner height.
     */
    function ResizeIframe(Iframe){
        Iframe = isJQueryObject(Iframe) ? Iframe.get(0) : Iframe;

        $(Iframe).on("load", function() {
            var $IframeContent = $(Iframe.contentDocument || Iframe.contentWindow.document),
                NewHeight = $IframeContent.height();
            if (!NewHeight || isNaN(NewHeight)) {
                NewHeight = 100;
            }
            else {
                if (NewHeight > 600) {
                    NewHeight = 600;
                }
            }

            NewHeight = parseInt(NewHeight, 10);
            $(Iframe).height(NewHeight + 'px');
        });

    }

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(Core.Customer.TileServiceCatalog || {}));
