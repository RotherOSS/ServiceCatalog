# --
# OTOBO is a web-based ticketing system for service organisations.
# --
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

    # System configuration.
    $Self->{Translation}->{'Show services with the following ticket type last.'} = 'Zeige Services mit folgendem Ticket-Typen als Letztes an.';

    # AdminService.tt
    # $Self->{Translation}->{'Only show services for ticket types'} = 'Services nur anzeigen bei Ticket-Typen';
    $Self->{Translation}->{'Ticket types for the customer portal (direct link)'} = 'Ticket-Typen für das Kundenportal (Direktlink)';

    # Template: TileServiceCatalog
    $Self->{Translation}->{'Find the right service for your ticket'} = 'Finde den richtigen Service für Dein Ticket';
    $Self->{Translation}->{'Service Catalog'} = 'Service-Katalog';
    $Self->{Translation}->{'You are here'} = 'Sie sind hier';

    # JS Template: TileServiceCatalog
    $Self->{Translation}->{'Sub-Service(s)'} = 'Unterservice(s)';
    $Self->{Translation}->{'sub-service(s) available'} = 'Unterservice(s) vorhanden';
    $Self->{Translation}->{'Show %s sub-service(s)'} = 'Zeige %s Unterservice(s)';
    $Self->{Translation}->{'Create %s'} = 'Erstelle %s';
    $Self->{Translation}->{'Service hours'} = 'Servicezeiten';
    $Self->{Translation}->{'Timeframe'} = 'Zeitfenster';
    $Self->{Translation}->{"o'clock"} = 'Uhr';
    $Self->{Translation}->{'Create a new ticket of type %s.'} = 'Ein neues Ticket des Typen %s erstellen.';
    $Self->{Translation}->{'Show details of this service.'} = 'Details zu diesem Service anzeigen.';
    $Self->{Translation}->{'More details'} = 'Mehr Details';
    $Self->{Translation}->{'Create a new ticket for this service.'} = 'Ein neues Ticket für diesen Service erstellen.';
    $Self->{Translation}->{'%s results'} = '%s Ergebnisse';
    $Self->{Translation}->{'%s results for %s'} = '%s Ergebnisse für %s';
    $Self->{Translation}->{'Additional information'} = 'Zusatzinformationen';
    $Self->{Translation}->{'FAQ article on this topic'} = 'FAQ-Artikel zu diesem Thema';
    $Self->{Translation}->{'Service Information'} = 'Service-Informationen';

    push @{ $Self->{JavaScriptStrings} // [] }, (
        'Service Catalog',
        'Sub-Service(s)',
        'sub-service(s) available',
        'Show %s sub-service(s)',
        'Create %s',
        'Create Ticket',
        'Service hours',
        'Timeframe',
        "o'clock",
        'Create a new ticket of type %s.',
        'Show details of this service.',
        'Create a new ticket for this service.',
        '%s results',
        '%s results for %s',
        'Additional information',
        'FAQ article on this topic',
        # From existing translations
        'First Response Time',
        'Solution Time',
        'hour(s)',
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun',
        'All',
        'Service Information',
        'Details',
        'More details',
    );

    return;
}

1;
