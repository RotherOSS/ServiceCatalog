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

package Kernel::Output::HTML::CustomerDashboard::TileServiceCatalog;

use strict;
use warnings;

use Kernel::Language qw(Translatable);
use Kernel::System::VariableCheck qw(IsArrayRefWithData);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::Language',
    'Kernel::Output::HTML::Layout',
    'Kernel::System::DateTime',
    'Kernel::System::HTMLUtils',
    'Kernel::System::Service',
    'Kernel::System::SLA',
    'Kernel::System::Ticket',
    'Kernel::System::Type',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $ConfigObject   = $Kernel::OM->Get('Kernel::Config');
    my $LanguageObject = $Kernel::OM->Get('Kernel::Language');
    my $LayoutObject   = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $SLAObject      = $Kernel::OM->Get('Kernel::System::SLA');

    my $DefaultTimeZone = $Kernel::OM->Create('Kernel::System::DateTime')->OTOBOTimeZoneGet();

    # Only get information of SLAs or calendars once and save them in hashes.
    my %SLAIDs = $SLAObject->SLAList(
        Valid     => 1,
        UserID    => 1,
    );

    # Get all SLA and associated calendar information.
    my %ServiceList;
    my %SLAList;
    my %CalendarList;
    my @WeekDays = ( 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun' );  # FIXME/Improve: Work with CalendarWeekDayStart
    for my $SLAID ( keys %SLAIDs ) {
        my %SLAData = $SLAObject->SLAGet(
            SLAID  => $SLAID,
            UserID => 1,
        );
        $SLAList{$SLAID} = \%SLAData;

        # Get all services which use this SLA.
        for my $ServiceID ( @{ $SLAData{ServiceIDs} } ) {
            push @{ $ServiceList{$ServiceID}{SLAIDs} }, $SLAID;
        }

        # Calendar does not exist yet.
        if ( $SLAData{Calendar} && !$CalendarList{ $SLAData{Calendar} } ) {
            # Get the calendar and the time zone.
            my $Calendar = $ConfigObject->Get( 'TimeWorkingHours::Calendar' . $SLAData{Calendar} );
            $Calendar->{TimeZone} = $ConfigObject->Get( 'TimeZone::Calendar' . $SLAData{Calendar} ) || $DefaultTimeZone;

            # Get working days and hours for the week. E.g.: Mo-Fr 12–19, Sat 13–19.
            my %Run;
            for my $Index ( 0 .. ( scalar @WeekDays - 1 ) ) {
                my $Day = $Calendar->{ $WeekDays[$Index] };

                # The day has working hours.
                if ( IsArrayRefWithData($Day) ) {
                    my $FirstHour = $Day->[0];
                    my $LastHour  = $Day->[$#$Day];

                    # First day of the run.
                    if ( !$Run{StartDay} ) {
                        $Run{StartDay}  = $WeekDays[$Index];
                        $Run{FirstHour} = $FirstHour;
                        $Run{LastHour}  = $LastHour;
                    } 
                    # The current date has different working hours than the last day of the run.
                    elsif ( $FirstHour != $Run{FirstHour} || $LastHour != $Run{LastHour} ) {
                        # Set the last day to yesterday and reset the run.
                        $Run{LastDay} = $WeekDays[ ( $Index - 1 ) ];
                        push @{ $Calendar->{WorkingHours} }, { %Run };
                        undef %Run;

                        $Run{StartDay}  = $WeekDays[$Index];
                        $Run{FirstHour} = $FirstHour;
                        $Run{LastHour}  = $LastHour;
                    }
                } else {
                    # No data for the day. Check if the run needs to be stopped.
                    if ( $Run{StartDay} ) {
                        $Run{LastDay} = $WeekDays[ ( $Index - 1 ) ];
                        push @{ $Calendar->{WorkingHours} }, { %Run };
                        undef %Run;
                    } 
                }
                # It's the last day of the week.
                if ( $Index == 6 ) {
                    # If the run is still going on, close it.
                    if ( $Run{StartDay} ) {
                        $Run{LastDay} = $WeekDays[$Index];
                        push @{ $Calendar->{WorkingHours} }, { %Run };
                    }
                }
            }

            $CalendarList{ $SLAData{Calendar} } = $Calendar;
        }
    }

    # Iterate through all avaliable services and filter out the sevices and parameters we need.
    my $ServiceListRefArray = $Kernel::OM->Get('Kernel::System::Service')->ServiceListGet(
        Valid  => 1,
        UserID => 1,
    );

    my %ServiceListRef;

    my %TypeList = $Kernel::OM->Get('Kernel::System::Type')->TypeList(
        Valid => 1,
    );

    # Get all service IDs of the customer.
    my %ServiceIDs = $Kernel::OM->Get('Kernel::System::Ticket')->TicketServiceList(
        CustomerUserID => $Param{UserID},
        QueueID        => 1,
    );

    my $Settings = $ConfigObject->Get( 'CustomerDashboard::Configuration::ServiceCatalog' ) || {}; 
    for my $ServiceRef ( @{$ServiceListRefArray} ) {
        $ServiceListRef{ $ServiceRef->{ServiceID} } = $ServiceRef;

        # Check if the customer has permission on this service.
        next if !$ServiceIDs{ $ServiceRef->{ServiceID} };
        my %Service = ();

        # Get all needed parameters
        for my $Needed ( qw(ServiceID NameShort DescriptionShort DescriptionLong TicketTypeIDs ParentID) ) {
            if ( $ServiceRef->{$Needed} ) {
                if ( $Needed eq 'TicketTypeIDs' ) {
                    # Get names of all assigned types.
                    for my $TypeID ( @{ $ServiceRef->{$Needed} } ) {
                        my $TypeName =  $LanguageObject->Translate( $TypeList{$TypeID} );
                        # Check if the assigned type ID is still valid.
                        if ($TypeName) {
                            $Service{TicketType}{$TypeName} = {
                                ID      => $TypeID,
                                Classes => $Settings->{ $TypeList{$TypeID} },
                            };
                        }
                    }
                } else {
                    $Service{$Needed} = $ServiceRef->{$Needed};
                }
            }
        }

        # Get all calendar and SLA information for this service.
        my $SLAIDs = $ServiceList{ $Service{ServiceID} }{SLAIDs};

        my %DontSet;
        for my $SLAID ( @{ $SLAIDs } ) {
            my $SLA = $SLAList{$SLAID};
            my $Calendar = $CalendarList{ $SLA->{Calendar} };

            # This service is linked to at least two SLAs with different first response times.
            if ( $Service{FirstResponseTime} && $Service{FirstResponseTime} ne $SLA->{FirstResponseTime} ) {
                undef $Service{FirstResponseTime};
                $DontSet{FirstResponseTime} = 1;
            } elsif ( !$DontSet{FirstResponseTime} ) {
                $Service{FirstResponseTime} = $SLA->{FirstResponseTime};
            }

            # This service is linked to at least two SLAs with different solution times.
            if ( $Service{SolutionTime} && $Service{SolutionTime} ne $SLA->{SolutionTime} ) {
                undef $Service{SolutionTime};
                $DontSet{SolutionTime} = 1;
            } elsif ( !$DontSet{SolutionTime} ) {
                $Service{SolutionTime} = $SLA->{SolutionTime};
            }

            # SLA does not have a calendar.
            next if !$Calendar;

            # This service is linked to at least two SLA calendars with different time zones. 
            if ( $Service{TimeZone} && $Calendar->{TimeZone} && $Service{TimeZone} ne $Calendar->{TimeZone} ) {
                undef $Service{TimeZone};
                undef $Service{WorkingHours};
                $DontSet{TimeZone} = 1;
                $DontSet{WorkingHours} = 1;
            } elsif ( !$DontSet{TimeZone} ) {
                $Service{TimeZone} = $Calendar->{TimeZone};
            }

            # This service is linked to at least two different calendars.
            if ( $Service{WorkingHours} ) {
                # Check if working hours are the same.
                for my $Index ( 0 .. ( scalar @{ $Service{WorkingHours} } - 1 ) ) {
                    if (
                        !$Service{WorkingHours}[$Index] || !$Calendar->{WorkingHours}[$Index] # Check if runs exist.
                        || $#{ $Service{WorkingHours} } != $#{ $Calendar->{WorkingHours} }    # One run is longer or shorter.
                        # Check if they have the same values.
                        || $Service{WorkingHours}[$Index]{StartDay}  ne $Calendar->{WorkingHours}[$Index]{StartDay}
                        || $Service{WorkingHours}[$Index]{LastDay}   ne $Calendar->{WorkingHours}[$Index]{LastDay}
                        || $Service{WorkingHours}[$Index]{FirstHour} ne $Calendar->{WorkingHours}[$Index]{FirstHour}
                        || $Service{WorkingHours}[$Index]{LastHour}  ne $Calendar->{WorkingHours}[$Index]{LastHour}
                        ) {
                            undef $Service{WorkingHours};
                            $DontSet{WorkingHours} = 1;
                            last;
                        } 
                }
            } elsif ( !$DontSet{WorkingHours} ) {
                $Service{WorkingHours} = $Calendar->{WorkingHours};
            }
        }

        # Save the service in a list.
        $ServiceList{ $Service{ServiceID} } = \%Service;
    }

    # Get the basic information for every parent Service, even if the the customer user does not have permission to see it.
    for my $ServiceID ( keys %ServiceList ) {
        my $ParentID = $ServiceList{$ServiceID}{ParentID};
        next if !$ParentID;

        if ( $ServiceList{$ParentID} && $ServiceList{$ParentID}{ServiceID} ) {
            next;
        }

        # Get sure that we can select every subservice of this service.
        while (1) {
            my %Service = ();

            for my $Needed ( qw(ServiceID NameShort DescriptionShort DescriptionLong ParentID) ) {
                if ( $ServiceListRef{$ParentID}{$Needed} ) {
                    $Service{$Needed} = $ServiceListRef{$ParentID}{$Needed};
                }
            }

            $Service{NotSelectable} = 1;
            $ServiceList{ $Service{ServiceID} } = \%Service;
            $ParentID = $Service{ParentID};

            # Parent reached.
            if ( !$Service{ParentID} || ( $ServiceList{$ParentID} && $ServiceList{$ParentID}{ServiceID} ) ) {
                last;
            }
        }
    }

    # Show all first level services, sorted by the name.
    my %ParentIDs;
    for my $ServiceID ( keys %ServiceList ) {
        next if $ServiceList{$ServiceID}{ParentID};
        # One of these can be undef if the parent service is disabled.
        next if !$ServiceList{$ServiceID};
        next if !$ServiceList{$ServiceID}{NameShort};

        $ParentIDs{$ServiceID} = $ServiceList{$ServiceID}{NameShort};
    }

    my %ReversedParentIDs = reverse %ParentIDs;
    for my $ServiceName (sort values %ParentIDs) {
        my $ServiceID = $ReversedParentIDs{$ServiceName};
        next if !$ServiceID;

        # Create the parent list.
        $LayoutObject->Block(
            Name => 'ParentService',
            Data => $ServiceList{$ServiceID},
        );
    }

    $LayoutObject->AddJSData(
        Key   => 'ServiceList',
        Value => $LayoutObject->JSONEncode(
            Data => \%ServiceList,
        ),
    );

    if ( $Settings->{SortByTicketType} ) {
        $LayoutObject->AddJSData(
            Key   => 'SortByTicketType',
            Value => $LanguageObject->Translate( $Settings->{SortByTicketType} ),
        );
    }

    my $Content = $LayoutObject->Output(
        TemplateFile => 'Dashboard/TileServiceCatalog',
        Data         => {
            TileID => $Param{TileID},
            %{ $Param{Config} },
        },
    );

    return $Content;
}

1;
