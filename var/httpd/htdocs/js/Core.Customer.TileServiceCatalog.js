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

            // Show the dialog if not already open.
            if (!$('.Dialog.Modal').length) {
                var ModalContainer = Core.Template.Render('Customer/TileServiceCatalogModal', {
                    ServiceStrg: JSON.parse(Core.Config.Get('ServiceStrg')),
                });

                Core.UI.Dialog.ShowDialog({
                    HTML: ModalContainer,
                    Modal: true,
                    CloseOnClickOutside: true,
                    CloseOnEscape: true,
                    PositionTop: '15px',
                    PositionLeft: 'Center',
                    AllowAutoGrow: false,
                    Stacked: true
                });
                $('.Dialog.Modal').attr({'data-service-id': ServiceID});
                $('.Dialog.Modal').addClass('oooServiceCatalogModal');
                // The search field is not needed anymore
                // $('.Dialog.Modal .oooServiceField').appendTo('.Dialog.Modal > .Header').find('select').attr('id', 'ModalServiceID');
                $('.oooServiceField').addClass('oooHidden');
                $('.Dialog.Modal .oooServiceFieldSearch').appendTo('.Dialog.Modal > .Header').find('select').attr('id', 'ModalSearch');
                $('.oooServiceBreadcrumbWrap').appendTo('.Dialog.Modal > .Header');
                // Core.UI.InputFields.Init();
                $('#ModalServiceID').val(ServiceID).trigger('redraw.InputField');
            }

            TargetNS.DisplayServiceList(ServiceID);
        });

        // Show subservices.
        $(document).on('click', '.Dialog .oooServiceContainer', function(Event) {
            if (
                $(Event.target).hasClass('ooofo-info') || $(Event.target).hasClass('ooofo-add') || $(Event.target).hasClass('oooServiceInformation')
                || $(Event.target).hasClass('oooServiceActions') || $(Event.target).hasClass('oooServiceActionDetails') ||  $(Event.target).hasClass('oooServiceBottom') || $(Event.target).hasClass('ooofo-arrow_r') 
                ) {
                return;
            }
            var ServiceID = $(this).attr('data-service-id');
            $('#ModalServiceID').val(ServiceID).trigger('redraw.InputField');
            $($('.Dialog.Modal').get(0)).attr({'data-service-id': $($('.Dialog.Modal').get(0)).attr('data-service-id') + ' ' + ServiceID});
            TargetNS.DisplayServiceList(ServiceID);
        });

        // Show the detailed view.
        $(document).on('click', '.oooServiceBottom, .oooServiceActionDetails', function() {
            var ServiceID = $(this).parent().attr('data-service-id');
            if (!ServiceID) return;
            TargetNS.DisplayDetailedService(ServiceID, true);
            return;
        });

        // Show or hide service actions.
        $(document).on('click', '.oooDesciptionHeader > .ooofo', function() {
            if ($(this).next().hasClass('oooServiceActions')) {
                if ($(this).next().hasClass('oooHidden')) {
                    $(this).next().removeClass('oooHidden');
                } else {
                    $(this).next().addClass('oooHidden');
                }
            }

        });

        $(document).on('click', '.Dialog span.oooSubservices', function(Event) {
            var ServiceID = $(this).attr('data-service-id');
            TargetNS.DisplayServiceList(ServiceID);
        });

        // Select a service when navbar field is changed.
        $(document).on('change', '#ModalServiceID', function() {
            var ServiceID = $(this).val();
            TargetNS.DisplayServiceList(ServiceID);
        });

        // Enable the search function.
        $(document).on('keyup', '.Dialog > .Header > .oooServiceFieldSearch > input', function() {
            var SearchString = $(this).val().toLowerCase();
            $('.Dialog .oooServiceContainer').each(function() {
                var ServiceName = $(this).find('.oooServiceName').text();
                if (ServiceName.toLowerCase().indexOf(SearchString.toLowerCase()) > -1) {
                    $(this).removeClass('oooHidden');
                } else {
                    $(this).addClass('oooHidden');
                }
            });

            // If no SearchString is given, hide all subservices with the class oooInitialHidden.
            if (SearchString == '') {
                $('.Dialog .oooInitialHidden').addClass('oooHidden');
            }

            // TODO Rebuild the breadcrumb. Show original breadcrumb if no search string is given.
        });

        // Show the quick action view for a service.
        $(document).on('click', '.oooDesciptionHeader > i', function(e) {
            return false;
        });
    }

    TargetNS.DisplayServiceList = function(ServiceID) {
        var Subservices = TargetNS.GetSubservices(ServiceID);

        // If there is only one subservice, jump straight into that list.
        if (Subservices.length == 1) {
            var Subservice = JSON.parse(Core.Config.Get('ServiceList'))[Subservices];

            // Only jump deeper if the subservice does not have the option to create a ticket for itself.
            if (!Subservice.TicketType) {
                return TargetNS.DisplayServiceList(Subservices[0]);
            }
        // If there is no subservice, show a detailed view of that service.
        } else if (Subservices.length == 0) {
            return TargetNS.DisplayDetailedService(ServiceID, $('.oooServiceWrapper').html().trim().length > 0);
        }

        $('.oooServiceWrapper').html('');
        $('.oooServiceResult').removeClass('oooHidden');
        // $('.oooServiceBreadcrumb').addClass('oooHidden');
        $('.oooServiceFieldSearch > input').focus(); // Autofocus the search field.
        // $('.oooServiceField').removeClass('oooHidden');
        $('.oooServiceFieldSearch').removeClass('oooHidden');
        $('.Dialog').removeClass('oooDetailedView');

	// Try to set the dynamic top
//        var Top = $('.oooServiceBreadcrumb').offset().top - $('.oooBreadcrumbServiceList > li').height() / 2;
//	$(".oooScrollLeft, .oooScrollRight").css('top', Top);

        var Top = $('.oooServiceBreadcrumb').position().top + $('.oooServiceBreadcrumb').height() / 2 - 7;
        var Left = $('.oooServiceBreadcrumb').position().left - 30;
        var Right = $('.oooServiceBreadcrumb').position().left + $('.oooServiceBreadcrumb').width() + 30;
        $(".oooScrollLeft, .oooScrollRight").css('top', Top);
        $(".oooScrollLeft").css('left', Left);
        $(".oooScrollRight").css('left', Right); 

        // Get all subservices for the search function.
        var AllSubservices = TargetNS.GetAllSubservices(ServiceID);
        for (var SubserviceID of AllSubservices) {
            // If the SubserviceID is not within the Subservices array, add the class 'oooHidden'.
            var Class = '';
            if (Subservices.indexOf(SubserviceID) == -1) {
                Class = 'oooHidden oooInitialHidden';
            }
            var DisplayServiceHTML = TargetNS.DisplayService(SubserviceID, Class);
            $(DisplayServiceHTML).appendTo('.oooServiceWrapper');
        } 

        TargetNS.CreateBreadcrumb(ServiceID);
    }

    TargetNS.DisplayService = function(ServiceID, Class = '') {
        var Service = JSON.parse(Core.Config.Get('ServiceList'))[ServiceID];
        var Baselink = Core.Config.Get('Baselink');
        var Container = Core.Template.Render('Customer/TileServiceCatalogContainer', {
            ID: ServiceID,
            Name:  Service.NameShort,
            DescriptionShort: Service.DescriptionShort,
            NumberOfSubservices: TargetNS.GetSubservices(ServiceID).length,
            TicketType: Service.TicketType,
            Baselink: Baselink,
            NotSelectable: Service.NotSelectable,
            Class: Class,
        });

        return Container;
    }

    TargetNS.DisplayDetailedService = function(ServiceID, StackDialog = false) {
        var Service = JSON.parse(Core.Config.Get('ServiceList'))[ServiceID];
        var Baselink = Core.Config.Get('Baselink');
        var IframeLink = Baselink + 'Action=CustomerTileServiceCatalog;Subaction=HTMLView;ServiceID=' + ServiceID + ';' + Core.Config.Get('SessionName') + '=' + Core.Config.Get('SessionID')
        // TODO: Refactor/remove this.
        var IframeLinkDynamicField = Baselink + 'Action=CustomerTileServiceCatalog;Subaction=DynamicFieldView;ServiceID=' + ServiceID + ';' + Core.Config.Get('SessionName') + '=' + Core.Config.Get('SessionID')

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

        // Get all subservices.
        var Subservices = TargetNS.GetSubservices(ServiceID);

        // For each Subservice, get the HTML.
        var SubservicesHTML = [];
        for (var SubserviceID of Subservices) {
            SubservicesHTML.push(TargetNS.DisplayService(SubserviceID));
        }

        var AdditionalInformation;
        if (Service.WorkingHours || SolutionTime || FirstResponseTime || Service.DynamicField) {
            AdditionalInformation = 1;
        }

        var Detailed = Core.Template.Render('Customer/TileServiceCatalogDetailed', {
            ID: ServiceID,
            Name:  Service.NameShort,
            DescriptionShort: Service.DescriptionShort,
            IframeLink: IframeLink,
            IframeLinkDynamicField: IframeLinkDynamicField,  // TODO: Delete this.
            DynamicFieldList: Service.DynamicField,
            WorkingHours: Service.WorkingHours,
            SolutionTime: SolutionTime,
            FirstResponseTime: FirstResponseTime,
            AdditionalInformation: AdditionalInformation,
            TypeList: Service.TicketType,
            Baselink: Baselink,
            FAQArticleList: Service.FAQs,
            NumberOfSubservices: TargetNS.GetSubservices(ServiceID).length,
            SubservicesHTML: SubservicesHTML,
        });

        if (StackDialog) {
            Core.UI.Dialog.ShowDialog({
                HTML: Detailed,
                Modal: true,
                CloseOnClickOutside: true,
                CloseOnEscape: true,
                PositionTop: '30px',
                PositionLeft: 'Center',
                AllowAutoGrow: false,
                Stacked: true
            });
            // $('.oooServiceBreadcrumbWrap').appendTo($('.Dialog.Modal > .Header'));
            const o = new MutationObserver(mrs => {
                mrs.forEach(mr => {
                    if (
                        'childList' === mr.type &&
                        Array.from(mr.removedNodes).find(
                            rn => rn.getAttribute('data-stacked')
                        )
                    ) {
                        let OldServiceID = $('.Dialog.Modal').attr('data-service-id').split(/ /).at(-2);
                        $('.Dialog.Modal').remove();
                        while ($('#Overlay').length) {
                            $('#Overlay').remove();
                        }
                        o.disconnect();
                        $($('.oooServiceIDAvailable').get(0)).click();
                        $('.oooServiceIDAvailable[data-service-id="All"]').click();
                        $('.oooServiceContainer[data-service-id="' + OldServiceID + '"]').click();
                    }
                });
            });
            o.observe($('div.Dialog[data-stacked]').get(-1).parentElement, { childList: true });
        } else {
            $('.oooServiceWrapper').html('');
            $(Detailed).appendTo('.oooServiceWrapper');
        }

        // Resize iFrame.
        var IFrame = $('.oooServiceWrapper').find('[data-service-id="' + ServiceID + '"]').find('iframe');
        ResizeIframe(IFrame);
        Core.UI.Init();

        TargetNS.CreateBreadcrumb(ServiceID);

        $('.Dialog').addClass('oooDetailedView');
        $('.oooServiceResult').addClass('oooHidden');
        // $('.oooServiceBreadcrumb').removeClass('oooHidden').appendTo('.Dialog > .Header');
        // $('.Dialog > .Content .oooDetailedTicketTypeList').appendTo('.Dialog > .Header');
        $('.oooServiceField').addClass('oooHidden');
        $('.oooServiceFieldSearch').addClass('oooHidden');
	// Try to set the dynamic top
	var Top = $('.oooServiceBreadcrumb').position().top + $('.oooServiceBreadcrumb').height() / 2 - 7;
        var Left = $('.oooServiceBreadcrumb').position().left - 30;
	var Right = $('.oooServiceBreadcrumb').position().left + $('.oooServiceBreadcrumb').width() + 30;
	$(".oooScrollLeft, .oooScrollRight").css('top', Top);
	$(".oooScrollLeft").css('left', Left);
	$(".oooScrollRight").css('left', Right);    

    }

    TargetNS.CreateBreadcrumb = function(ServiceID) {
        var Service = JSON.parse(Core.Config.Get('ServiceList'));
        var SelectedService = Service[ServiceID];

        // Show the number of displayed services.
        var NumberOfServices = $('.oooServiceContainer:not(.oooHidden)').length;

        if (SelectedService) {
            $('.oooServiceResult').text(Core.Language.Translate('%s results for %s', NumberOfServices, SelectedService.NameShort));
        } else {
            $('.oooServiceResult').text(Core.Language.Translate('%s results', NumberOfServices));
        }

        var LiString = '';
        // var LiString = '<i class="oooScrollLeft ooofo-arrow_l"></i>';
 
        // Add the current service to the list.
        if (ServiceID != 'All') {
            LiString += '<li data-service-id="' + SelectedService.ServiceID + '" class="oooServiceIDAvailable oooServiceIDSelected">' + SelectedService.NameShort + '</li>';
        }

        // Add 'All' to the list.
        LiString += '<li data-service-id="All" class="oooServiceIDAvailable ' + ( ServiceID == 'All'  ? 'oooServiceIDSelected' : '') + '">' + Core.Language.Translate('All') + '</li>';

        // Get all main level services.
        for (var ServiceIDLoop in Service) {
            if (Service[ServiceIDLoop].ParentID) continue;  // Skip if the service has a parent.
            if (ServiceIDLoop == ServiceID) continue;  // Don't show the current service twice.
            if (!Service[ServiceIDLoop].NameShort) continue;  // TODO/FIXME: Workaround Stefan R. This should not be necessary, fix in .pm.

            LiString += '<li data-service-id="' + ServiceIDLoop + '" class="oooServiceIDAvailable">' + Service[ServiceIDLoop].NameShort + '</li>';
        }

        // LiString += '<i class="oooScrollRight ooofo-arrow_r"></i>';

        // var LiString = '<li data-service-id="' + SelectedService.ServiceID + '" class="oooServiceIDAvailable">' + SelectedService.NameShort + '</li>';
        // Limit the number of shown parents.
        // for (var i = 0; i < 10; i++) {
        //     var ParentID = SelectedService.ParentID;
        //     if (!ParentID) break;

        //     SelectedService = Service[ParentID];
        //     LiString = '<li data-service-id="' + SelectedService.ServiceID + '" class="oooServiceIDAvailable">' + SelectedService.NameShort + '</li><i class="ooofo ooofo-arrow_r"></i>' + LiString;
        // }

        $('.oooBreadcrumbServiceList').html(LiString);

        // Scroll services list.
        const goLeft = crumb => crumb.scrollLeft(crumb.scrollLeft() - crumb.width());
        const goRight = crumb => crumb.scrollLeft(crumb.scrollLeft() + crumb.width());
        $('.oooScrollLeft').click(
            e => goLeft($(e.target).parent().find('.oooServiceBreadcrumbField'))
        );
        $('.oooScrollRight').click(
            e => goRight($(e.target).parent().find('.oooServiceBreadcrumbField'))
        );
        $('.oooServiceBreadcrumbField').on('wheel', e => {
            switch(true) {
                case e.originalEvent.deltaY < 0:
                    goLeft($(e.delegateTarget));
                    break;
                case e.originalEvent.deltaY > 0:
                    goRight($(e.delegateTarget));
                    break;
            }
            e.preventDefault();
        })
    }

    /**
     * @private
     * @name GetSubservices
     * @memberof Core.Customer.TileServiceCatalog
     * @function
     * @param {String} ServiceID - ID of the service
     * @description
     *     Get the subservices of a service.
     */
    TargetNS.GetSubservices = function(ServiceID) {
        var Service = JSON.parse(Core.Config.Get('ServiceList'));

        // Iterate through all services and get all subservices of ServiceID.
        var UnorderedSubservices = {};
        for (var ChildID in Service) {
            if (ServiceID == Service[ChildID].ParentID) {
                UnorderedSubservices[Service[ChildID].NameShort] = ChildID;
            } else if (ServiceID == 'All') {
                // If the all filter is set, get all services.
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
     * @name GetAllSubservices
     * @memberof Core.Customer.TileServiceCatalog
     * @function
     * @param {String} ServiceID - ID of the service
     * @description
     *     Get all subservices recursively of a service.
     */
    TargetNS.GetAllSubservices = function(ServiceID) {
        var Service = JSON.parse(Core.Config.Get('ServiceList'));
        
        // Get all subservices of ServiceID.
        var Subservices = TargetNS.GetSubservices(ServiceID);
        var AllSubservices = Subservices;

        // While there are still subservices, get all subservices of the current subservices.
        while (Subservices.length > 0) {
            var NewSubservices = [];
            $.each(Subservices, function(Index, SubserviceID) {
                var SubSubservices = TargetNS.GetSubservices(SubserviceID);
                NewSubservices = NewSubservices.concat(SubSubservices);
            });
            Subservices = NewSubservices;
            AllSubservices = AllSubservices.concat(Subservices);
        }

        // Remove all duplicates (important for the 'All' filter).
        AllSubservices = AllSubservices.filter(function (Item, Index, Array) {
            return Array.indexOf(Item) === Index;
        });

        return AllSubservices;
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
    function ResizeIframe(Iframe) {
        Iframe = isJQueryObject(Iframe) ? Iframe.get(0) : Iframe;

        $(Iframe).on('load', function() {
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
