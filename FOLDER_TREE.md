# Repository Folder Structure

This document provides an overview of the folder structure for the MESM Math Bootcamp Website repository.

## Repository Tree

```
MESM-math-bootcamp-website/
├── _freeze/                          # Quarto freeze directory (cached computations)
│   ├── notes/                        # Cached note computations by day
│   │   ├── day1_algebra/
│   │   ├── day2_limits/
│   │   ├── day3_derivatives/
│   │   ├── day4_integrals/
│   │   └── day5_differential_equations/
│   └── site_libs/                    # Cached site libraries
│       ├── clipboard/
│       ├── crosstalk-1.2.2/
│       ├── datatables-binding-0.34.0/
│       ├── datatables-css-0.0.0/
│       ├── dt-core-1.13.6/
│       ├── htmltools-fill-0.5.8.1/
│       ├── htmlwidgets-1.6.4/
│       ├── jquery-3.6.0/
│       └── revealjs/
│
├── docs/                             # Generated website output (published to GitHub Pages)
│   ├── notes/                        # Rendered HTML notes by day
│   │   ├── day1_algebra/
│   │   ├── day2_limits/
│   │   ├── day3_derivatives/
│   │   ├── day4_integrals/
│   │   ├── day5_differential_equations/
│   │   └── about.html
│   ├── site_libs/                    # Website libraries and dependencies
│   │   ├── bootstrap/
│   │   ├── clipboard/
│   │   ├── crosstalk-1.2.2/
│   │   ├── datatables-binding-0.34.0/
│   │   ├── datatables-css-0.0.0/
│   │   ├── dt-core-1.13.6/
│   │   ├── htmltools-fill-0.5.8.1/
│   │   ├── htmlwidgets-1.6.4/
│   │   ├── jquery-3.6.0/
│   │   ├── quarto-html/
│   │   ├── quarto-nav/
│   │   ├── quarto-search/
│   │   └── revealjs/
│   ├── index.html                    # Main website homepage
│   └── search.json                   # Search index for website
│
├── notes/                            # Source content for workshop materials
│   ├── about.qmd                     # About page content
│   ├── day1_algebra/                 # Day 1: Algebra materials
│   │   ├── images/                   # Images for algebra content
│   │   ├── day1_algebra.qmd         # Day 1 main page
│   │   ├── in-lecture-exercises-limits.pdf  # Preview exercises for Day 2
│   │   ├── lecture-algebra.qmd      # Algebra lecture slides
│   │   ├── problem_set_algebra.qmd  # Algebra problem set
│   │   └── solutions_problem_set_algebra.qmd
│   ├── day2_limits/                  # Day 2: Limits materials
│   │   ├── images/                   # Images for limits content
│   │   ├── lecture-limits_files/    # Supporting files for limits lecture
│   │   ├── day2_limits.qmd          # Day 2 main page
│   │   ├── lecture-limits.qmd       # Limits lecture slides
│   │   ├── problem_set_limits.qmd   # Limits problem set
│   │   └── solutions_problem_set_limits.qmd
│   ├── day3_derivatives/             # Day 3: Derivatives materials
│   │   ├── images/                   # Images for derivatives content
│   │   ├── day3_derivatives.qmd     # Day 3 main page
│   │   ├── lecture-derivative.qmd   # Derivatives lecture slides
│   │   ├── problem_set_derivatives.qmd
│   │   └── solutions_problem_set_derivative.qmd
│   ├── day4_integrals/               # Day 4: Integrals materials
│   │   ├── images/                   # Images for integrals content
│   │   ├── day4_integrals.qmd       # Day 4 main page
│   │   ├── lecture-integrals.qmd    # Integrals lecture slides
│   │   ├── problem_set_integrals.qmd
│   │   └── solutions_problem_set_integrals.qmd
│   └── day5_differential_equations/  # Day 5: Differential Equations materials
│       ├── images/                   # Images for differential equations content
│       ├── day5_differential_equations.qmd  # Day 5 main page
│       └── lecture-diffeq.qmd       # Differential equations lecture slides
│
├── .gitignore                        # Git ignore file
├── _quarto.yml                       # Quarto project configuration
├── copy-images.sh                    # Shell script to copy images
├── index.qmd                         # Homepage source file
├── README.md                         # Repository documentation
└── ucsb-media.scss                   # UCSB branding styles

```

## Directory Descriptions

### Root Level Files

- **README.md**: Main documentation for the repository, including workshop description and instructor information
- **index.qmd**: Quarto source file for the website homepage
- **_quarto.yml**: Configuration file for the Quarto project (defines site structure, theme, etc.)
- **ucsb-media.scss**: SCSS stylesheet for UCSB/Bren branding
- **copy-images.sh**: Utility script for copying images between directories
- **.gitignore**: Specifies files and directories to be ignored by Git

### Main Directories

#### `notes/`
Contains the source Quarto (`.qmd`) files for all workshop materials organized by day. Each day's folder includes:
- Lecture slides
- Problem sets
- Solutions
- Supporting images

#### `docs/`
The built/rendered website output generated by Quarto. This directory is published to GitHub Pages and contains:
- Rendered HTML files
- JavaScript libraries and dependencies
- CSS stylesheets
- Search functionality

#### `_freeze/`
Quarto's caching directory that stores computed results to speed up subsequent builds. This helps avoid re-running expensive computations during development.

## Workshop Structure

The workshop is organized as a 5-day course covering:

1. **Day 1**: Algebra
2. **Day 2**: Limits
3. **Day 3**: Derivatives
4. **Day 4**: Integrals
5. **Day 5**: Differential Equations

Each day's materials are self-contained within their respective folders in the `notes/` directory.

## Build Process

This is a Quarto website project. To build the site:

1. Edit source files in the root and `notes/` directories
2. Run Quarto to render the site
3. Output is generated in the `docs/` directory
4. The `docs/` directory is published to GitHub Pages

## Website

The rendered website is available at: [https://mesm-math-bootcamp.github.io/MESM-math-bootcamp-website/](https://mesm-math-bootcamp.github.io/MESM-math-bootcamp-website/)
