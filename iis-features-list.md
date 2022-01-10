FeatureName      : IIS-WebServerRole
DisplayName      : Internet Information Services
Description      : Internet Information Services provides support for Web and FTP servers, along with support for ASP.NET web sites, dynamic content such as Classic ASP and CGI, and local and remote management.
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-WebServer
DisplayName      : World Wide Web Services
Description      : Installs the IIS 10.0 World Wide Web Services. Provides support for HTML web sites and optional support for ASP.NET, Classic ASP, and web server extensions.
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-CommonHttpFeatures
DisplayName      : Common HTTP Features
Description      : Installs support for Web server content such as HTML and image files.
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-HttpErrors
DisplayName      : HTTP Errors
Description      : Allows you to customize the error messages returned to clients
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-HttpRedirect
DisplayName      : HTTP Redirection
Description      : Redirect client requests to a specific destination
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-ApplicationDevelopment
DisplayName      : Application Development Features
Description      : Install Web server application development features
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-Security
DisplayName      : Security
Description      : Enable additional security features to secure servers, sites, applications, vdirs, and files
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-RequestFiltering
DisplayName      : Request Filtering
Description      : Configure rules to block selected client requests.
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-NetFxExtensibility
DisplayName      : .NET Extensibility 3.5
Description      : Enable your Web server to host .NET Framework 3.5 applications
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-NetFxExtensibility45
DisplayName      : .NET Extensibility 4.8
Description      : Enable your Web server to host .NET Framework v4.8 applications
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-HealthAndDiagnostics
DisplayName      : Health and Diagnostics
Description      : Enables you to monitor and manage server, site, and application health
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-HttpLogging
DisplayName      : HTTP Logging
Description      : Enables logging of Web site activity for this server
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-LoggingLibraries
DisplayName      : Logging Tools
Description      : Install IIS 10.0 logging tools and scripts
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-RequestMonitor
DisplayName      : Request Monitor
Description      : Monitor server, site, and application health
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-HttpTracing
DisplayName      : Tracing
Description      : Enable tracing for ASP.NET applications and failed requests
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-URLAuthorization
DisplayName      : URL Authorization
Description      : Authorize client access to the URLs that comprise a Web application.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-IPSecurity
DisplayName      : IP Security
Description      : Allow or deny content access based on IP address or domain name.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-Performance
DisplayName      : Performance Features
Description      : Install performance features
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-HttpCompressionDynamic
DisplayName      : Dynamic Content Compression
Description      : Compress dynamic content before returning it to client
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-WebServerManagementTools
DisplayName      : Web Management Tools
Description      : Install Web management console and tools
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-ManagementScriptingTools
DisplayName      : IIS Management Scripts and Tools
Description      : Manage a local Web server with IIS configuration scripts
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-IIS6ManagementCompatibility
DisplayName      : IIS 6 Management Compatibility
Description      : Allows you to use existing IIS 6.0 APIs and scripts to manage this IIS 10.0 web server
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-Metabase
DisplayName      : IIS Metabase and IIS 6 configuration compatibility
Description      : Install IIS metabase and compatibility layer to allow metabase calls to interact with new IIS 10.0 configuration store
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-HostableWebCore
DisplayName      : Internet Information Services Hostable Web Core
Description      : Program your application to serve HTTP requests by using core IIS functionality.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-StaticContent
DisplayName      : Static Content
Description      : Serve .htm, .html, and image files from a Web site
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-DefaultDocument
DisplayName      : Default Document
Description      : Allows you to specify a default file to be loaded when users do not specify a file in a request URL
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-DirectoryBrowsing
DisplayName      : Directory Browsing
Description      : Allow clients to see the contents of a directory on your Web server
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-WebDAV
DisplayName      : WebDAV Publishing
Description      : Publish and manage files on a Web server by using the HTTP protocol.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-WebSockets
DisplayName      : WebSocket Protocol
Description      : IIS 10.0 and ASP.NET 4.8 support writing server applications that communicate over the WebSocket Protocol.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-ApplicationInit
DisplayName      : Application Initialization
Description      : Application Initialization perform expensive web application initialization tasks before serving web pages.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-ASPNET
DisplayName      : ASP.NET 3.5
Description      : Enable your Web server to host ASP.NET 3.5 applications
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-ASPNET45
DisplayName      : ASP.NET 4.8
Description      : Enable your Web server to host ASP.NET v4.8 applications
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-ASP
DisplayName      : ASP
Description      : Enable your Web server to host Classic ASP applications
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-CGI
DisplayName      : CGI
Description      : Enable support for CGI executables
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-ISAPIExtensions
DisplayName      : ISAPI Extensions
Description      : Allow ISAPI extensions to handle client requests
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-ISAPIFilter
DisplayName      : ISAPI Filters
Description      : Allow ISAPI filters to modify Web server behavior
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-ServerSideIncludes
DisplayName      : Server-Side Includes
Description      : Serve .stm, .shtm, and .shtml files from a Web site
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-CustomLogging
DisplayName      : Custom Logging
Description      : Enable support for custom logging for Web servers, sites, and applications
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-BasicAuthentication
DisplayName      : Basic Authentication
Description      : Require a valid Windows user name and password for connection.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-HttpCompressionStatic
DisplayName      : Static Content Compression
Description      : Compress static content before returning it to a client
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-ManagementConsole
DisplayName      : IIS Management Console
Description      : Install Web server Management Console which supports management of local and remote Web servers.
RestartRequired  : Possible
State            : Enabled
CustomProperties :


FeatureName      : IIS-ManagementService
DisplayName      : IIS Management Service
Description      : Allow the web server to be managed remotely from another computer via the Web server Management Console
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-WMICompatibility
DisplayName      : IIS 6 WMI Compatibility
Description      : Install IIS 6.0 WMI scripting interfaces
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-LegacyScripts
DisplayName      : IIS 6 Scripting Tools
Description      : Install IIS 6.0 configuration scripts
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-LegacySnapIn
DisplayName      : IIS 6 Management Console
Description      : Install the IIS 6.0 Management Console. Provides support for administration of remote IIS 6.0 servers from this computer.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-FTPServer
DisplayName      : FTP Server
Description      : Enable your server to transfer files by using the FTP protocol.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-FTPSvc
DisplayName      : FTP Service
Description      : Enable FTP publishing on a Web server.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-FTPExtensibility
DisplayName      : FTP Extensibility
Description      : Customize FTP publishing by writing your own software extensions.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-CertProvider
DisplayName      : Centralized SSL Certificate Support
Description      : Centralized SSL Certificate Support enables you to manage SSL server certificates centrally using a file share. Maintaining SSL server certificates on a file share simplifies management since there is one place to
                   manage them.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-WindowsAuthentication
DisplayName      : Windows Authentication
Description      : Authenticate clients by using NTLM or Kerberos.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-DigestAuthentication
DisplayName      : Digest Authentication
Description      : Authenticate clients by sending a password hash to a Windows domain controller.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-ClientCertificateMappingAuthentication
DisplayName      : Client Certificate Mapping Authentication
Description      : Authenticate client certificates with Active Directory accounts.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-IISCertificateMappingAuthentication
DisplayName      : IIS Client Certificate Mapping Authentication
Description      : Map client certificates 1-to-1 or many-to-1 to a Windows security identity.
RestartRequired  : Possible
State            : Disabled
CustomProperties :


FeatureName      : IIS-ODBCLogging
DisplayName      : ODBC Logging
Description      : Enable support for logging to an ODBC-compliant database.
RestartRequired  : Possible
State            : Disabled
CustomProperties :