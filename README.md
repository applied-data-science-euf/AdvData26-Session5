# Applied Data Science — Session 5: live coding

The R script we wrote together in session 5 (26.10.2026): 
building a `ggplot2` chart step by step, from an empty canvas to a
saved, faceted figure of hotel prices against distance in three cities.

## What is in here

| Path | What it is |
|---|---|
| `R/first_visualization.R` | The script from class, tidied after the session |
| `data/hotels-europe.csv` | The hotels-europe data (Békés & Kézdi 2021) |
| `output/` | Where the script saves the chart (`three_cities.pdf`) |

> **Note:** We ignore the `.pdf` files that our scripts save because they are
reproducible output and there is no need to track it in git. To still keep the
`output` directory we added a placeholder file (`.gitkeep`), such that the 
directory is still tracked in git and the code does not produce an error message 
after cloning the repo (as empty directories are not included).

## How to run it

1. Get a copy of the repository — clone it (preferred) or download it, see below.
2. Open `AdvData26-Session5.Rproj` in RStudio.
3. Make sure the packages are installed:
   `install.packages(c("tidyverse", "scales", "here"))`
4. Open `R/first_visualization.R` and run it line by line.

The script uses `here()`, so it finds `data/` regardless of your working
directory — as long as you opened the project.

### Clone the repository (preferred)

Cloning gives you a local copy that is linked to this repository. Pick one of
the following ways.

**In RStudio:** *File → New Project → Version Control → Git*, paste

```
https://github.com/applied-data-science-euf/AdvData26-Session5.git
```

as the repository URL, choose where to save it and click *Create Project*.
RStudio opens the project straight away, so you can skip step 2.

**From R**, with `usethis` (as in session 4):

```r
usethis::create_from_github("applied-data-science-euf/AdvData26-Session5", fork = FALSE)
```

**In the terminal:**

```bash
git clone https://github.com/applied-data-science-euf/AdvData26-Session5.git
```

### Download the code

If you do not want to use Git: green **Code** button → **Download ZIP**, then
unzip it. You get the same files, but no link to this repository.

## Licence

The data are from Békés, G. and Kézdi, G. (2021), 
*Data Analysis for Business, Economics, and Policy*, 
Cambridge University Press, licensed under
[CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

The repo as such runs under the MIT License.
