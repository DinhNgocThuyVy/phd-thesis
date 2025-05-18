[![github](https://img.shields.io/github/v/release/NguyenTruongAnLab/quarto-thesis?color=brightgreen&label=GitHub)](https://github.com/NguyenTruongAnLab/quarto-thesis/releases/latest)

# Quarto Thesis with Automated Deployment

Quarto extension for a masters or PhD thesis based on Masters/Doctoral Thesis, LaTeX Template, Version 2.5 (27 Aug 2017). You can play with it on RStudio Cloud without installing anything: https://rstudio.cloud/content/4383755  Go to the Build tab (upper right panel) and click Render Book.

## Automated Deployment Features

This repository is set up with automated workflows for:

1. **GitHub Pages Deployment**: The thesis website is automatically deployed to GitHub Pages from the `/docs` folder.

2. **Automatic PDF Versioning**: When changes are pushed to the main branch, a GitHub Actions workflow:
   - Renders the Quarto project to PDF
   - Creates a versioned PDF with timestamp (e.g., `Thesis-v2023-05-15-10-30-45.pdf`)
   - Creates a GitHub Release with both the standard PDF and versioned PDF
   - Updates the GitHub Pages website

3. **Manual Release Option**: You can still create manual releases using the `create-release.ps1` PowerShell script.

## Automated Workflow Details

### GitHub Actions Workflows

This repository contains the following GitHub Actions workflows:

1. **`auto-pdf-release.yml`**: Main workflow that automatically:
   - Renders the Quarto project when changes are pushed to main
   - Generates a PDF of the thesis
   - Creates a versioned copy of the PDF with timestamp
   - Creates a GitHub Release with the PDFs
   - Deploys the website to GitHub Pages

2. **`create-release.yml`**: Creates a release when the PDF file changes
   - Triggered when `docs/Titre-de-la-Thèse.pdf` is modified
   - Creates a GitHub Release with versioned PDF

3. **`pdf-release.yml`**: Creates a release when a tag is pushed
   - Used with manual tag creation

### Manual Release Process

You can still create releases manually with the PowerShell script:

```powershell
# Simple use (will generate timestamp version)
.\create-release.ps1

# With custom version and message
.\create-release.ps1 -Version "1.0.0" -Message "Final thesis version"

# Render the thesis before creating the release
.\create-release.ps1 -Render
```

### GitHub Pages Configuration

The thesis website is served from the `/docs` folder. This is configured in:
- `_quarto.yml` with `output-dir: docs`
- GitHub repository settings > Pages > Source set to "Deploy from a branch" with branch "/docs"

## Quick Start!

* Make changes to your thesis content in the `Chapters` folder
* Commit and push to the main branch
* The workflow will automatically create a new release with versioned PDFs
* View your thesis website at `https://nguyentruonganlab.github.io/quarto-thesis/`

Original template videos:
* How to download a zip and open in RStudio: [Video](https://youtu.be/33l8GhtUfnU)
* How to use this repo as a template and clone to a computer with RStudio: [Video](https://youtu.be/smzNQtogSaI)
* How to render in Visual Studio Code: [Video](https://youtu.be/IJe3A8-Ee2E)


## Installing the extension

You will need to do this to get all the folders with tex files. Start in the directory where you will create the directory that will contain your thesis files. Run this from a terminal in that directory.

```bash
quarto use template nmfs-opensci/quarto-thesis
```

It will ask for an empty directory name where to put the files, give it a new directory name.

Once you do that you can cd to the new directory and render from within the directory.

```bash
quarto render
```

## Installation or updating for an existing document

You may also use this format with an existing Quarto project or document. But you will need to have all the tex folders already (see above).

```bash
quarto install extension nmfs-opensci/quarto-thesis
```

## Usage

### Customizing the look

For a LaTeX document, the class file `MasterDoctoralThesis.cls` in the `_extensions/quarto-thesis` determines the look and LaTeX environments available. To make any changes to the layout, change the MasterDoctoralThesis.cls **in the _extensions folder**. The `MastersDoctoralThesis.cls` file in the main folder will be overwritten by the one in the `_extensions` folder when you re-rerender.  To get info on the MasterDoctoralThesis document class, do a web search for `MasterDoctoralThesis.cls`. You'll find some documentation.

### Adding content

* start adding Chapters in qmd format to the Chapters folder.
* then add the chapter (or appendix) to the `_quarto.yml` file

<img width="305" alt="image" src="https://github.com/nmfs-opensci/quarto-thesis/assets/2545978/3cbd21f5-185f-4930-8699-a623af15fd84">


## Getting and giving help

First try the Discussion link because there may be a solution there. Have a solution to post or want to show how you have used this template? Post to the discussion forum too! You'll find links to other Quarto thesis templates there too.

If you think it's a bug, then definitely post an issue and I'll look into it! 

## Contributors

[![Contributors](https://contrib.rocks/image?repo=nmfs-opensci/quarto-thesis)](https://github.com/nmfs-opensci/quarto-thesis/graphs/contributors)

This template is based on the [Masters/Doctoral Thesis, LaTeX Template, Version 2.5 (27 Aug 2017)](https://www.latextemplates.com/template/masters-doctoral-thesis). Other Quarto thesis examples:


## Problems

* All the stuff in Frontmatter is mandatory LaTeX since it is being injected into the tex document after the qmd is processed. Probably need to learn how to write a lua filter to render the Frontmatter qmd to LaTeX via Pandoc.

* I doubt that passing in `classoptions` in your `_quarto.yml` will work. The [elsevier lua filter](https://github.com/quarto-journals/elsevier/blob/main/_extensions/elsevier/elsevier.lua) suggests that the classoptions need to be added on.

* Why does `index-blx.bib` keep appearing?

## Warning. Chapter 1 has R code

Python and Julia users: After you install the extension, search for `{r}` in `Chapters/Chapter1.qmd` and get rid of the R code (for a table and a figure) or replace with Python or Julia code.
