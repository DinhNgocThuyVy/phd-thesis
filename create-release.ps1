# Create a new release tag and push it to GitHub
# This will trigger the PDF release workflow
#
# Note: This script is for manual use. The GitHub Actions workflow will
# automatically create releases when changes are pushed to the main branch.

param(
    [Parameter(Mandatory=$false)]
    [string]$Version,
    
    [Parameter(Mandatory=$false)]
    [string]$Message = "",
    
    [Parameter(Mandatory=$false)]
    [switch]$Render = $false,
    
    [Parameter(Mandatory=$false)]
    [switch]$CreateVersionedPDF = $true,
    
    [Parameter(Mandatory=$false)]
    [switch]$Push = $true
)

# If no version is provided, generate one from the current date and time
if (!$Version) {
    $Version = Get-Date -Format "yyyy-MM-dd-HH-mm-ss"
    Write-Output "No version provided. Using timestamp: $Version"
}

# If no message is provided, create a default one
if (!$Message) {
    $Message = "Thesis update $Version"
}

# Check if Git is available
try {
    git --version | Out-Null
} catch {
    Write-Error "Git is not available. Please make sure Git is installed and in your PATH."
    exit 1
}

# Render the thesis if requested
if ($Render) {
    Write-Output "Rendering thesis with Quarto..."
    try {
        # Check if Quarto is available
        if (!(Get-Command quarto -ErrorAction SilentlyContinue)) {
            Write-Error "Quarto is not available. Please make sure Quarto is installed and in your PATH."
            exit 1
        }
        
        quarto render
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Quarto render failed with exit code $LASTEXITCODE"
            exit 1
        }
        Write-Output "Thesis rendered successfully."
    } catch {
        Write-Error "Failed to render thesis: $_"
        exit 1
    }
}

# Create a versioned copy of the PDF
if ($CreateVersionedPDF) {
    $pdfSourcePath = "docs/Titre-de-la-Thèse.pdf"
    
    # Ensure release_assets folder exists
    if (!(Test-Path -Path "release_assets")) {
        New-Item -ItemType Directory -Force -Path "release_assets"
    }
    
    $pdfDestPath = "release_assets/Thesis-v$Version.pdf"
    
    if (Test-Path $pdfSourcePath) {
        Write-Output "Creating versioned PDF: $pdfDestPath"
        Copy-Item -Path $pdfSourcePath -Destination $pdfDestPath -Force
        
        # Add the versioned PDF to git
        git add $pdfDestPath
    } else {
        Write-Warning "PDF not found at $pdfSourcePath. Skipping versioned PDF creation."
    }
}

# Ensure version starts with 'v'
if (!$Version.StartsWith("v")) {
    $Version = "v$Version"
}

# Check if git is installed
try {
    git --version | Out-Null
} catch {
    Write-Error "Git is not installed or not in PATH. Please install git."
    exit 1
}

# Make sure we're in a git repository
if (!(Test-Path -Path ".git")) {
    Write-Error "Not a git repository. Please run this script from the root of your thesis repository."
    exit 1
}

# Make sure working directory is clean
$status = git status --porcelain
if ($status) {
    Write-Warning "Working directory is not clean. Please commit or stash your changes before creating a release."
    Write-Output "Changes:"
    Write-Output $status
    $confirmation = Read-Host "Do you want to continue anyway? (y/N)"
    if ($confirmation -ne "y" -and $confirmation -ne "Y") {
        exit 0
    }
}

# Make sure we have the latest changes from remote
Write-Output "Pulling latest changes..."
git pull

# Create a tag
Write-Output "Creating tag $Version..."
git tag -a $Version -m $Message

# Push the tag
Write-Output "Pushing tag to GitHub..."
git push origin $Version

Write-Output "Release tag $Version created and pushed to GitHub."
Write-Output "The PDF release workflow will automatically start."
Write-Output "Check the status at: https://github.com/$(git config --get remote.origin.url | Select-String -Pattern 'github.com[:/]([^/]+/[^/\.]+)' | ForEach-Object { $_.Matches.Groups[1].Value })/actions"
