<#
.SYNOPSIS
    Installs the Windows side of these dotfiles: the Noctty config and themes,
    and optionally the Bitwarden SSH agent setup.

.DESCRIPTION
    Copies config/noctty/config.ghostty to %LOCALAPPDATA%\noctty and installs
    every Ghostty-format theme from iterm2colorschemes.com into
    %LOCALAPPDATA%\noctty\themes. An existing config.ghostty is backed up
    first. Works on Windows PowerShell 5.1 and PowerShell 7.

    install.sh handles Linux and the Linux side of WSL. This script needs no
    WSL. Only -BitwardenSshAgent asks for admin rights.

.PARAMETER SkipThemes
    Copies the config only and does not download themes.

.PARAMETER BitwardenSshAgent
    Prepares Windows for the Bitwarden SSH agent. Installs npiperelay, which
    lets WSL reach the agent, into %LOCALAPPDATA%\Programs\npiperelay. Then
    asks for admin rights once to stop and disable the Windows "OpenSSH
    Authentication Agent" service, because Bitwarden takes over its pipe.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\windows\install.ps1
#>
[CmdletBinding()]
param(
    [switch]$SkipThemes,
    [switch]$BitwardenSshAgent
)

$ErrorActionPreference = 'Stop'

# Source of the Noctty themes: the iTerm2-Color-Schemes repository.
$ThemesUrl = 'https://codeload.github.com/mbadolato/iTerm2-Color-Schemes/zip/refs/heads/master'
$RepoRoot = Split-Path -Parent $PSScriptRoot
$NocttyDir = Join-Path $env:LOCALAPPDATA 'noctty'

# npiperelay bridges a WSL socket to a Windows named pipe. The albertony fork
# is maintained; the original jstarks release stopped at v0.1.0 in 2020.
# Pin the version and its SHA-256 from the release's npiperelay_checksums.txt.
$NpiperelayUrl = 'https://github.com/albertony/npiperelay/releases/download/v1.12.2/npiperelay_windows_amd64.exe'
$NpiperelaySha256 = 'e6d3475f8eccd34a5b264ae3946fe0b24154c69fb192fd72e1232f38eeafced8'
$NpiperelayDir = Join-Path $env:LOCALAPPDATA 'Programs\npiperelay'

function Write-Info([string]$Message) { Write-Host "[INFO] $Message" -ForegroundColor Cyan }
function Write-Warn([string]$Message) { Write-Host "[WARNING] $Message" -ForegroundColor Yellow }
function Write-Ok([string]$Message) { Write-Host "[SUCCESS] $Message" -ForegroundColor Green }

# Same backup naming as install.sh: <file>.backup.<yyyyMMdd_HHmmss>.
function Backup-File([string]$Path) {
    if (Test-Path -LiteralPath $Path -PathType Leaf) {
        $backup = "$Path.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Move-Item -LiteralPath $Path -Destination $backup
        Write-Warn "Backed up existing $(Split-Path -Leaf $Path) to $(Split-Path -Leaf $backup)"
    }
}

function Install-NocttyConfig {
    $source = Join-Path $RepoRoot 'config\noctty\config.ghostty'
    if (-not (Test-Path -LiteralPath $source)) {
        throw "Source file not found: $source"
    }
    New-Item -ItemType Directory -Force -Path $NocttyDir | Out-Null
    $target = Join-Path $NocttyDir 'config.ghostty'
    Backup-File $target
    Copy-Item -LiteralPath $source -Destination $target
    Write-Info "Copied config.ghostty to $target"
}

# Noctty bundles only part of the iTerm2-Color-Schemes collection. Install
# every Ghostty-format theme into the user themes directory, which Noctty
# searches before its bundled ones. The user directory survives Noctty
# updates and needs no admin rights.
function Install-NocttyThemes {
    $archive = Join-Path ([IO.Path]::GetTempPath()) ("noctty-themes-" + [guid]::NewGuid() + '.zip')
    try {
        try {
            # TLS 1.2 is not the default on Windows PowerShell 5.1.
            [Net.ServicePointManager]::SecurityProtocol =
                [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri $ThemesUrl -OutFile $archive -UseBasicParsing
        }
        catch {
            Write-Warn "Could not download iTerm2 color schemes; skipping Noctty themes ($_)"
            return
        }

        $target = Join-Path $NocttyDir 'themes'
        New-Item -ItemType Directory -Force -Path $target | Out-Null

        # Read the zip with .NET instead of tar.exe: Windows tar cannot rename
        # entries, and it cannot create a file whose name holds ':'.
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        $zip = [IO.Compression.ZipFile]::OpenRead($archive)
        try {
            $count = 0
            foreach ($entry in $zip.Entries) {
                # Entries look like "<repo>-master/ghostty/<theme name>".
                if ($entry.FullName -notmatch '^[^/]+/ghostty/([^/]+)$') { continue }
                # Windows file names cannot hold <>:"/\|?*, so "Foo: Bar"
                # installs as the theme "Foo - Bar".
                $name = ($Matches[1] -replace ':', ' -') -replace '[<>"\\|?*]', '-'
                [IO.Compression.ZipFileExtensions]::ExtractToFile(
                    $entry, (Join-Path $target $name), $true)
                $count++
            }
        }
        finally {
            $zip.Dispose()
        }
        Write-Info "Installed $count Noctty themes into $target"
    }
    finally {
        Remove-Item -LiteralPath $archive -Force -ErrorAction SilentlyContinue
    }
}

function Install-Npiperelay {
    $target = Join-Path $NpiperelayDir 'npiperelay.exe'
    if ((Test-Path -LiteralPath $target) -and
        (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -eq $NpiperelaySha256) {
        Write-Info "npiperelay is already installed at $target"
        return
    }

    $download = Join-Path ([IO.Path]::GetTempPath()) ("npiperelay-" + [guid]::NewGuid() + '.exe')
    try {
        [Net.ServicePointManager]::SecurityProtocol =
            [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $NpiperelayUrl -OutFile $download -UseBasicParsing
        $hash = (Get-FileHash -LiteralPath $download -Algorithm SHA256).Hash
        if ($hash -ne $NpiperelaySha256) {
            throw "npiperelay checksum mismatch: expected $NpiperelaySha256, got $hash"
        }
        New-Item -ItemType Directory -Force -Path $NpiperelayDir | Out-Null
        Move-Item -LiteralPath $download -Destination $target -Force
        Write-Info "Installed npiperelay into $target"
    }
    finally {
        Remove-Item -LiteralPath $download -Force -ErrorAction SilentlyContinue
    }
}

# Bitwarden serves SSH keys on the same pipe as the Windows OpenSSH agent,
# so that service must be off (https://bitwarden.com/help/ssh-agent/).
function Disable-WindowsSshAgent {
    $service = Get-Service ssh-agent -ErrorAction SilentlyContinue
    if (-not $service) {
        Write-Info 'Windows OpenSSH agent service is not installed; nothing to disable'
        return
    }
    if ($service.Status -eq 'Stopped' -and $service.StartType -eq 'Disabled') {
        Write-Info 'Windows OpenSSH agent service is already disabled'
        return
    }

    Write-Info 'Asking for admin rights to disable the Windows OpenSSH agent service'
    $command = 'Stop-Service ssh-agent; Set-Service ssh-agent -StartupType Disabled'
    try {
        Start-Process powershell.exe -Verb RunAs -Wait -WindowStyle Hidden `
            -ArgumentList '-NoProfile', '-Command', $command
    }
    catch {
        Write-Warn "Could not disable the Windows OpenSSH agent service ($_)"
        return
    }

    $service = Get-Service ssh-agent
    if ($service.Status -eq 'Stopped' -and $service.StartType -eq 'Disabled') {
        Write-Info 'Disabled the Windows OpenSSH agent service'
    }
    else {
        Write-Warn "Windows OpenSSH agent service is $($service.Status), $($service.StartType)"
    }
}

Install-NocttyConfig
if ($SkipThemes) {
    Write-Info 'Skipping Noctty themes (-SkipThemes)'
}
else {
    Install-NocttyThemes
}
Write-Ok 'Noctty setup finished. Reload a running Noctty with Ctrl+Shift+comma.'

if ($BitwardenSshAgent) {
    Install-Npiperelay
    Disable-WindowsSshAgent
    Write-Ok 'Bitwarden SSH agent setup finished.'
    Write-Info 'Next: in Bitwarden Desktop, open Settings and turn on "Enable SSH agent".'
    Write-Info 'Then run ./install.sh in WSL to connect WSL to the agent.'
}
