# Create a new release tag and push it to GitHub
# This will trigger the PDF release workflow

param(
    [Parameter(Mandatory=$false)]
    [string]$Version,
    
    [Parameter(Mandatory=$false)]
    [string]$Message = "",
    
    [Parameter(Mandatory=$false)]
    [switch]$Render = $false
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

# Render the thesis if requested
if ($Render) {
    Write-Output "Rendering thesis with Quarto..."
    try {
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
