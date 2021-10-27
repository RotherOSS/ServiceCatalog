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
            var ServiceID = $(this).parent().attr('id').split('ServiceID')[1];
            TargetNS.DisplayDetailedService(ServiceID);
        });

        // Show subservices.
        $(document).on('click', '.oooDescriptionShort, .oooSubservices', function() {
            var ServiceID = $(this).parent().attr('id').split('ServiceID')[1];
            TargetNS.DisplayServiceList(ServiceID);
        });
    }

    TargetNS.DisplayServiceList = function(ServiceID) {
        var Subservices = TargetNS.GetAllSubservices(ServiceID);

        // If there is only one subservice, jump straight into that list.
        if (Subservices.length == 1) {
            return TargetNS.DisplayServiceList(Subservices[0]);
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
        });

        $(Container).appendTo('.oooServiceWrapper')
    }

    TargetNS.DisplayDetailedService = function(ServiceID) {
        TargetNS.ClearServices();
        var Service = JSON.parse(Core.Config.Get('ServiceList'))[ServiceID];
        var Baselink = Core.Config.Get('Baselink');

        // Convert minutes to hours and round to the first decimal place.
        var SolutionTime, FirstResponseTime;
        if (Service.SolutionTime) {
            SolutionTime = Service.SolutionTime / 60;
            SolutionTime = Math.round(SolutionTime * 10) / 10;
        }
        if (Service.FirstResponseTime) {
            FirstResponseTime = Service.FirstResponseTime / 60;
            FirstResponseTime = Math.round(FirstResponseTime * 10) / 10;
        }

        var Detailed = Core.Template.Render('Customer/TileServiceCatalogDetailed', {
            ID: ServiceID,
            Name:  Service.NameShort,
            DescriptionShort: Service.DescriptionShort,
            DescriptionLong: Service.DescriptionLong,
            WorkingHours: Service.WorkingHours,
            SolutionTime: SolutionTime,
            FirstResponseTime: FirstResponseTime,
            TypeList: Service.TicketType,
            Baselink: Baselink,
        });

        $(Detailed).appendTo('.oooServiceWrapper');

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

        $('.Dialog .oooServiceBreadcrumbField').html('<ul class="oooChildServiceList">' + LiString + '</ul>');
    }

    TargetNS.GetAllSubservices = function(ServiceID) {
        var Service = JSON.parse(Core.Config.Get('ServiceList'));
        // Iterate through all services and get all subservices of ServiceID.
        var Subservices = [];
        for (var ChildID in Service) {
            if (ServiceID == Service[ChildID].ParentID) {
                Subservices.push(ChildID);
            }
        }
        return Subservices;
    }

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(Core.Customer.TileServiceCatalog || {}));
