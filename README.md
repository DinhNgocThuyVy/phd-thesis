# Université Grenoble Alpes Thesis Template for Quarto

[![Render Thesis](https://github.com/DinhNgocThuyVy/phd-thesis/actions/workflows/render-thesis.yml/badge.svg)](https://github.com/DinhNgocThuyVy/phd-thesis/actions/workflows/render-thesis.yml)
[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Live-brightgreen)](https://dinhngocthuyvy.github.io/phd-thesis/)
[![Latest Release](https://img.shields.io/github/v/release/DinhNgocThuyVy/phd-thesis)](https://github.com/DinhNgocThuyVy/phd-thesis/releases/latest)

This template provides a framework for writing a PhD thesis in Quarto for Université Grenoble Alpes, France. It is designed to be flexible, allowing either the use of a custom cover page (required by many French universities) or an automatically generated title page based on thesis metadata.

## 🚀 Quick Links

- **📖 [Read Online (HTML)](https://dinhngocthuyvy.github.io/phd-thesis/)** - Latest version
- **📄 [Download PDF](https://github.com/DinhNgocThuyVy/phd-thesis/releases/latest)** - Latest release
- **⚙️ [GitHub Actions Setup](GITHUB_ACTIONS_README.md)** - Multi-computer workflow guide

## Features

- Support for both custom PDF cover pages and auto-generated title pages
- Complete French thesis information fields (supervisor, co-supervisor, committee members, etc.)
- Customizable university logo or multiple logos
- Support for doctoral schools, laboratory information, and thesis numbers
- French-style committee member formatting with roles

## Cover Page Options

You have two options for the thesis cover page:

### Option 1: Custom PDF Cover Page

If your university requires a specific cover page format (common in French institutions), you can create a `cover.pdf` file in the project root directory and set `use-custom-cover: true` in `_quarto.yml`. This will use your custom cover page as the first page of the thesis.

### Option 2: Auto-generated Title Page

If you don't have a specific cover page requirement, set `use-custom-cover: false` and the template will generate a professional title page using the thesis information you provide in `_quarto.yml`.

## Customizing Thesis Information

The template supports the following thesis information fields:

### Basic Information
- `title`: Title of your thesis
- `subtitle`: Optional subtitle
- `author`: Your full name
- `submitted`: Year of submission
- `degree`: Degree name (e.g., "Docteur de l'Université Grenoble Alpes")
- `defense-date`: Date of public defense (e.g., "17 mai 2025")
- `discipline`: Field of study/discipline (e.g., "Informatique")

### University Information
- `university-name`: University name (defaults to "Université Grenoble Alpes")
- `university-logo`: Path to university logo image file (PDF, PNG or JPG format - SVG is not compatible with XeTeX)
- `logos`: Alternative to university-logo, allows multiple logos with custom positioning (use only PDF, PNG, or JPG formats)

### Department and Organizational Information
- `faculty`: Name of your faculty (e.g., "UFR IM2AG")
- `department`: Name of your department
- `laboratory`: Your research laboratory name
- `laboratory-address`: Physical address of your laboratory

### Doctoral Information
- `doctoral-school`: Your doctoral school name
- `doctoral-school-address`: Physical address of your doctoral school
- `thesis-number`: Thesis registration number

### Supervision & Committee
- `supervisor`: Thesis supervisor name
- `co-supervisor`: Co-supervisor name (if applicable)
- `committee-members`: Committee members using French-style tabular format

### Additional Features
- `citation-start` and `citation-author`: For adding a quote or dedication page

## Example Configuration

```yaml
# Basic information
title: "Titre de la Thèse"
subtitle: "Sous-titre optionnel"
author: "Nom Prénom"
submitted: 2025
degree: "Docteur de l'Université Grenoble Alpes"
defense-date: "17 mai 2025"
discipline: "Informatique"

# University information
university-name: "Université Grenoble Alpes" 
university-logo: "logo.pdf"  # Use PDF, PNG or JPG format (SVG is not supported)

# Multiple logos option (uncomment to use)
# logos: |
#   \includegraphics[width=0.25\textwidth]{logos/university.pdf}
#   \includegraphics[width=0.15\textwidth]{logos/laboratory.pdf}
#   \hfill
#   \includegraphics[width=0.15\textwidth]{logos/cnrs.pdf}

# Department and organizational information
department: "Département d'Informatique"
faculty: "UFR IM2AG"
laboratory: "Laboratoire d'Informatique de Grenoble"
laboratory-address: "700 Avenue Centrale, 38400 Saint-Martin-d'Hères"

# Doctoral school information
doctoral-school: "MSTII"
doctoral-school-address: "110 rue de la Chimie, 38400 Saint-Martin-d'Hères"
thesis-number: "2025-UGA-123"

# Supervision information
supervisor: "Prof. Jean Dupont"
co-supervisor: "Dr. Marie Lambert"

# Committee members - using the French tabular format
committee-members: |
  \begin{tabular}{llcl}
      M. & Jean Dupont & \textit{Université Grenoble Alpes} & Directeur\\
      Mme. & Marie Curie & \textit{Université Paris-Saclay} & Rapportrice\\
      M. & Albert Einstein & \textit{CNRS}& Examinateur\\
      Mme. & Ada Lovelace & \textit{Université Grenoble Alpes} & Présidente\\
  \end{tabular}

# Cover page option
format:
  uga-thesis-template-pdf:
    use-custom-cover: false  # false = auto-generate French-style title page
                            # true = use cover.pdf from project root
```

## Getting Started

1. Clone or download this template
2. Edit `_quarto.yml` to include your thesis information
3. Choose your cover page option (custom or auto-generated)
4. Edit the chapter files or create new ones as needed
5. Run `quarto render` to build your thesis

## Required Files

- For custom cover: `cover.pdf` in the project root
- For auto-generated title page: `logo.pdf`, `logo.png` or `logo.jpg` for university logo (SVG format is not supported with XeTeX)


## Working with Python Code Blocks

All Python code blocks should use this format:

````markdown
```{python}
#| label: fig-name
#| fig-cap: "Figure caption"
#| echo: false
#| warning: false

# Your Python code here
```
````

For tables, use:

````markdown
```{python}
#| label: tbl-name
#| tbl-cap: "Table caption"
#| echo: false

# Create dataframe
df = pd.DataFrame(...)

# Display table using Markdown
from IPython.display import Markdown
display(Markdown(df.to_markdown(index=False)))
```
````

## Citations

Citations use standard Markdown syntax:

- Reference a citation: `[@citation-key]`
- Multiple citations: `[@key1; @key2]`

Bibliography files are configured in `_quarto.yml`.

## Tips for Working with Figures and Tables

1. **Matplotlib Configuration:**
   - Always set figure sizes explicitly with `plt.figure(figsize=(width, height))` for consistency.

2. **Tables:**
   - Use `IPython.display` and `Markdown` to render tables rather than using print statements.
   - This ensures proper formatting in both HTML and PDF outputs.

3. **Cross-References:**
   - Reference figures with `@fig-name` and tables with `@tbl-name`.
   - Example: "As seen in @fig-temporal-patterns, the data shows seasonal variation."

## Python Code Blocks
- [ ] All code blocks use proper Quarto syntax: ```{python}
- [ ] All code blocks include appropriate YAML options:
  - `echo: false` - Hides code from output
  - `warning: false` - Hides warnings from output
  - `message: false` - Hides messages from output
  - `label: fig-name` or `label: tbl-name` - For cross-references
  - `fig-cap: "Caption text"` or `tbl-cap: "Caption text"` - For captions
- [ ] No `plt.show()` calls in the code (figures are automatically displayed)
- [ ] Tables use `from IPython.display import Markdown` and `display(Markdown())` instead of print statements

## Citations and References
- [ ] All citations use proper Markdown syntax: `[@citation-key]`
- [ ] All bibliography files are listed in `_quarto.yml`
- [ ] No "??" or missing citations in the rendered document

## Equations
- [ ] All equations render properly in both HTML and PDF formats
- [ ] Equation references use proper syntax: `@eq-label`

## Cross-References
- [ ] All figures can be referenced with `@fig-name`
- [ ] All tables can be referenced with `@tbl-name`
- [ ] All sections can be referenced with `@sec-name`
