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
            ShortName        = 'WF'
            TenantId         = '${dsc-tenantname}.onmicrosoft.com'
            OrganizationName = '${dsc-tenantname}.onmicrosoft.com'
        }
        Accounts       = @(
            @{
                Workload = 'Exchange'
                Account  = '${dsc-admin-user}'
            }
            @{
                Workload = 'Office365'
                Account  = '${dsc-admin-user}'
            }
            @{
                Workload = 'PowerPlatform'
                Account  = '${dsc-admin-user}'
            }
            @{
                Workload = 'SecurityCompliance'
                Account  = '${dsc-admin-user}'
            }
            @{
                Workload = 'SharePoint'
                Account  = '${dsc-admin-user}'
            }
            @{
                Workload = 'Teams'
                Account  = '${dsc-admin-user}'
            }
        )
        AppCredentials = @(
            @{
                Workload       = 'Exchange'
                ApplicationId  = '${dsc-app-id}'
                CertThumbprint = '${dsc-cert-thumb}'
            }
            @{
                Workload       = 'Office365'
                ApplicationId  = '${dsc-app-id}'
                CertThumbprint = '${dsc-cert-thumb}'
            }
            @{
                Workload       = 'PowerPlatform'
                ApplicationId  = '${dsc-app-id}'
                CertThumbprint = '${dsc-cert-thumb}'
            }
            @{
                Workload       = 'SecurityCompliance'
                ApplicationId  = '${dsc-app-id}'
                CertThumbprint = '${dsc-cert-thumb}'
            }
            @{
                Workload       = 'SharePoint'
                ApplicationId  = '${dsc-app-id}'
                CertThumbprint = '${dsc-cert-thumb}'
            }
            @{
                Workload       = 'Teams'
                ApplicationId  = '${dsc-app-id}'
                CertThumbprint = '${dsc-cert-thumb}'
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
                    Identity        = '${dsc-tenantname}.onmicrosoft.com'
                    DomainType      = 'Authoritative'
                    MatchSubDomains = $false
                    OutboundOnly    = $false
                    Ensure          = 'Present'
                }
            )
            DKIM                        = @(
                @{
                    Identity               = '${dsc-tenantname}.onmicrosoft.com'
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