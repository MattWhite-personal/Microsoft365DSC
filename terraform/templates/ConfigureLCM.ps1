Configuration ConfigureLCM {
    Import-DscResource -ModuleName PsDesiredStateConfiguration
    node localhost {
        LocalConfigurationManager {
            ConfigurationMode = "ApplyOnly"
            CertificateId = ${dsc_cert_thumbprint}
        }
    }
}

ConfigureLcm
