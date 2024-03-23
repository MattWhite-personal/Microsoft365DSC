@{
    AllNodes    = @(
        @{
            NodeName                    = 'localhost'
            CertificateFile             = '.\DSCCertificate.cer'
            PsDscAllowPlainTextPassword = $true
            PsDscAllowDomainUser        = $true
        }
    )
    NonNodeData = @{
        Environment    = @{
            Name             = 'The White Family'
            ShortName        = 'thewhitefamily'
            TenantId         = 'thewhitefamily.onmicrosoft.com'
            OrganizationName = 'thewhitefamily.onmicrosoft.com'
        }
        Accounts       = @(
            @{
                Workload = 'Exchange'
                Account  = 'm365dscadmin@thewhitefamily.onmicrosoft.com'
            }
            @{
                Workload = 'Office365'
                Account  = 'm365dscadmin@thewhitefamily.onmicrosoft.com'
            }
            @{
                Workload = 'PowerPlatform'
                Account  = 'm365dscadmin@thewhitefamily.onmicrosoft.com'
            }
            @{
                Workload = 'SecurityCompliance'
                Account  = 'm365dscadmin@thewhitefamily.onmicrosoft.com'
            }
            @{
                Workload = 'SharePoint'
                Account  = 'm365dscadmin@thewhitefamily.onmicrosoft.com'
            }
            @{
                Workload = 'Teams'
                Account  = 'm365dscadmin@thewhitefamily.onmicrosoft.com'
            }
        )
        AppCredentials = @(
            @{
                Workload       = 'Exchange'
                ApplicationId  = '48e3eb7b-44b8-4ab0-a0ff-82c8cd427131'
                CertThumbprint = '7E40DD792A9CF519A6F93967476C83D239B44300'
            }
            @{
                Workload       = 'Office365'
                ApplicationId  = '48e3eb7b-44b8-4ab0-a0ff-82c8cd427131'
                CertThumbprint = '7E40DD792A9CF519A6F93967476C83D239B44300'
            }
            @{
                Workload       = 'PowerPlatform'
                ApplicationId  = '48e3eb7b-44b8-4ab0-a0ff-82c8cd427131'
                CertThumbprint = '7E40DD792A9CF519A6F93967476C83D239B44300'
            }
            @{
                Workload       = 'SecurityCompliance'
                ApplicationId  = '48e3eb7b-44b8-4ab0-a0ff-82c8cd427131'
                CertThumbprint = '7E40DD792A9CF519A6F93967476C83D239B44300'
            }
            @{
                Workload       = 'SharePoint'
                ApplicationId  = '48e3eb7b-44b8-4ab0-a0ff-82c8cd427131'
                CertThumbprint = '7E40DD792A9CF519A6F93967476C83D239B44300'
            }
            @{
                Workload       = 'Teams'
                ApplicationId  = '48e3eb7b-44b8-4ab0-a0ff-82c8cd427131'
                CertThumbprint = '7E40DD792A9CF519A6F93967476C83D239B44300'
            }
        )
        Exchange       = @{
            OrganizationalRelationships = @(
                @{
                    Name                  = "fabrikam.com"
                    ArchiveAccessEnabled  = $false
                    DeliveryReportEnabled = $false
                    DomainNames           = @("fabrikam.onmicrosoft.com")
                    Enabled               = $true
                    FreeBusyAccessEnabled = $true
                    FreeBusyAccessLevel   = "LimitedDetails"
                    MailboxMoveEnabled    = $false
                    MailTipsAccessEnabled = $false
                    MailTipsAccessLevel   = "None"
                    OrganizationContact   = ""
                    PhotosEnabled         = $false
                    TargetApplicationUri  = "outlook.com"
                    TargetAutodiscoverEpr = "https://autodiscover-s.outlook.com/autodiscover/autodiscover.svc/WSSecurity"
                    TargetOwaURL          = ""
                    TargetSharingEpr      = ""
                }
            )
            AcceptedDomains             = @(
                @{
                    Identity        = 'mattandjen.co.uk'
                    DomainType      = 'Authoritative'
                    MatchSubDomains = $false
                    OutboundOnly    = $false
                    Ensure          = 'Present'
                },
                @{
                    Identity        = 'thewhitefamily.onmicrosoft.com'
                    DomainType      = 'Authoritative'
                    MatchSubDomains = $false
                    OutboundOnly    = $false
                    Ensure          = 'Present'
                },
                @{
                    Identity        = 'simonwhitedesign.co.uk'
                    DomainType      = 'Authoritative'
                    MatchSubDomains = $false
                    OutboundOnly    = $false
                    Ensure          = 'Present'
                },
                @{
                    Identity        = 'matthewjwhite.co.uk'
                    DomainType      = 'Authoritative'
                    MatchSubDomains = $false
                    OutboundOnly    = $false
                    Ensure          = 'Present'
                },
                @{
                    Identity        = 'tonyandlizwhite.co.uk'
                    DomainType      = 'Authoritative'
                    MatchSubDomains = $false
                    OutboundOnly    = $false
                    Ensure          = 'Present'
                }

            )
            DKIM                        = @(
                @{
                    Identity               = 'thewhitefamily.onmicrosoft.com'
                    Enabled                = $true
                    AdminDisplayName       = ''
                    BodyCanonicalization   = 'Relaxed'
                    HeaderCanonicalization = 'Relaxed'
                    KeySize                = 1024
                },
                @{
                    Identity               = 'mattandjen.co.uk'
                    Enabled                = $true
                    AdminDisplayName       = ''
                    BodyCanonicalization   = 'Relaxed'
                    HeaderCanonicalization = 'Relaxed'
                    KeySize                = 1024
                },
                @{
                    Identity               = 'simonandhanna.co.uk'
                    Enabled                = $true
                    AdminDisplayName       = ''
                    BodyCanonicalization   = 'Relaxed'
                    HeaderCanonicalization = 'Relaxed'
                    KeySize                = 1024
                },
                @{
                    Identity               = 'matthewjwhite.co.uk'
                    Enabled                = $true
                    AdminDisplayName       = ''
                    BodyCanonicalization   = 'Relaxed'
                    HeaderCanonicalization = 'Relaxed'
                    KeySize                = 1024
                },
                @{
                    Identity               = 'simonwhitedesign.co.uk'
                    Enabled                = $true
                    AdminDisplayName       = ''
                    BodyCanonicalization   = 'Relaxed'
                    HeaderCanonicalization = 'Relaxed'
                    KeySize                = 1024
                },
                @{
                    Identity               = 'tonyandlizwhite.co.uk'
                    Enabled                = $true
                    AdminDisplayName       = ''
                    BodyCanonicalization   = 'Relaxed'
                    HeaderCanonicalization = 'Relaxed'
                    KeySize                = 1024
                }
            )
            InboundConnectors           = @()
            OutboundConnectors          = @()
        }
        Teams          = @{
            MeetingBroadcastConfiguration = @{
                Identity                            = "Global"
                AllowSdnProviderForBroadcastMeeting = $false
                SdnApiTemplateUrl                   = ""
                SdnApiToken                         = ""
                SdnLicenseId                        = ""
                SdnProviderName                     = ""
                SupportURL                          = "https://support.office.com/home/contact"
            }
            MeetingBroadcastPolicies      = @(
                @{
                    Identity                        = "Global"
                    AllowBroadcastScheduling        = $false
                    AllowBroadcastTranscription     = $true
                    BroadcastAttendeeVisibilityMode = "EveryoneInCompany"
                    BroadcastRecordingMode          = "UserOverride"
                }
            )
            MeetingConfiguration          = @{
                Identity                    = "Global"
                ClientAppSharingPort        = 50040
                ClientAppSharingPortRange   = 20
                ClientAudioPort             = 50000
                ClientAudioPortRange        = 20
                ClientMediaPortRangeEnabled = $true
                ClientVideoPort             = 50020
                ClientVideoPortRange        = 20
                DisableAnonymousJoin        = $false
                EnableQoS                   = $false
            }
            MeetingPolicies               = @(
                @{
                    Identity                                   = "Global"
                    AllowAnonymousUsersToDialOut               = $false
                    AllowAnonymousUsersToStartMeeting          = $false
                    AllowBreakoutRooms                         = $true
                    AllowChannelMeetingScheduling              = $true
                    AllowCloudRecording                        = $false
                    AllowEngagementReport                      = "Disabled"
                    AllowExternalParticipantGiveRequestControl = $true
                    AllowIPAudio                               = $true
                    AllowIPVideo                               = $true
                    AllowMeetingReactions                      = $true
                    AllowMeetNow                               = $true
                    AllowNDIStreaming                          = $false
                    AllowOrganizersToOverrideLobbySettings     = $false
                    AllowOutlookAddIn                          = $true
                    AllowParticipantGiveRequestControl         = $true
                    AllowPowerPointSharing                     = $true
                    AllowPrivateMeetingScheduling              = $true
                    AllowPrivateMeetNow                        = $true
                    AllowPSTNUsersToBypassLobby                = $true
                    AllowRecordingStorageOutsideRegion         = $false
                    AllowSharedNotes                           = $true
                    AllowTranscription                         = $false
                    AllowUserToJoinExternalMeeting             = "Disabled"
                    AllowWhiteboard                            = $true
                    AutoAdmittedUsers                          = "EveryoneInCompanyExcludingGuests"
                    DesignatedPresenterRoleMode                = "EveryoneInCompanyUserOverride"
                    EnrollUserOverride                         = "Disabled"
                    IPAudioMode                                = "EnabledOutgoingIncoming"
                    IPVideoMode                                = "EnabledOutgoingIncoming"
                    LiveCaptionsEnabledType                    = "DisabledUserOverride"
                    MediaBitRateKb                             = 50000
                    MeetingChatEnabledType                     = "Enabled"
                    PreferredMeetingProviderForIslandsMode     = "TeamsAndSfb"
                    RecordingStorageMode                       = "OneDriveForBusiness"
                    ScreenSharingMode                          = "EntireScreen"
                    StreamingAttendeeMode                      = "Disabled"
                    TeamsCameraFarEndPTZMode                   = "Disabled"
                    VideoFiltersMode                           = "AllFilters"
                    WhoCanRegister                             = "EveryoneInCompany"
                }
            )
        }
    }
}