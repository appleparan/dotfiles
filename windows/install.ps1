<#
.SYNOPSIS
    Installs the Windows side of these dotfiles: the Noctty config and themes.

.DESCRIPTION
    Copies config/noctty/config.ghostty to %LOCALAPPDATA%\noctty and installs
    every Ghostty-format theme from iterm2colorschemes.com into
    %LOCALAPPDATA%\noctty\themes. An existing config.ghostty is backed up
    first. Works on Windows PowerShell 5.1 and PowerShell 7.

    install.sh handles Linux and the Linux side of WSL. This script needs no
    WSL and no admin rights.

.PARAMETER SkipThemes
    Copies the config only and does not download themes.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\windows\install.ps1
#>
[CmdletBinding()]
param(
    [switch]$SkipThemes
)

$ErrorActionPreference = 'Stop'

# Source of the Noctty themes: the iTerm2-Color-Schemes repository.
$ThemesUrl = 'https://codeload.github.com/mbadolato/iTerm2-Color-Schemes/zip/refs/heads/master'
$RepoRoot = Split-Path -Parent $PSScriptRoot
$NocttyDir = Join-Path $env:LOCALAPPDATA 'noctty'

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

Install-NocttyConfig
if ($SkipThemes) {
    Write-Info 'Skipping Noctty themes (-SkipThemes)'
}
else {
    Install-NocttyThemes
}
Write-Ok 'Noctty setup finished. Reload a running Noctty with Ctrl+Shift+comma.'
