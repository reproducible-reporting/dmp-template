[![Creative Commons License](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

This work is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](http://creativecommons.org/licenses/by-nc-sa/4.0/).


# Data Management Plan for StepUp-based Projects

This repository aims to provide a data management plan for research projects
where all source data (scripts, reports, etc.) are version-controlled with Git.
The document emphasizes the use of StepUp for publication repositories,
but this is not a strict requirement.
You can also use StepUp for non-publication repositories,
e.g. to process datasets of or to build computational workflows.


## Version history

The history of changes to this repository are listed in [CHANGELOG.md](CHANGELOG.md).
Version numbers are of the form `{MAJOR}.{MINOR}`:

- An increase in the major version number implies a change
  in the fields available in [`fields.yaml`]({{cookiecutter.slug}}/fields.yaml).
- The minor version number is increased after significant changes
  to the template (without changing the available fields or their meaning).

Versions are tagged commits in the Git history.
Author contributions can also be found in the Git history.


## Creating a DMP for a new project.

You must have
[Python](https://www.python.org/) 3,
[Git](https://git-scm.com/),
[direnv](https://direnv.net/)
and the [Cookiecutter](https://www.cookiecutter.io/)
installed on your computer.
It is assumed that you are familiar with these tools and know how to use them.

1. Instantiate a new DMP from the template:

    ```bash
    cookiecutter https://github.com/reproducible-reporting/dmp-template
    ```

    Follow the instructions on the screen, which will ask you to fill in some fields:

    - `slug`:
      This is a short name for the directory containing the sources and compiled outputs.
      Use only lower case letters, numbers and hyphens, no spaces.
      It is recommended to start the slug with `dmp-`.
    - `short_name`:
      A short name for the project, not too many characters, no spaces.
    - `long_name`:
      The official name of the project, e.g. from the grant application.

2. Initialize a Git repository:

    ```bash
    cd `slug`
    git init
    git add .
    git commit -a -m "Initial commit"
    ```

3. Create a software environment

    ```bash
    ./setup-venv-pip.sh
    direnv allow
    ```

4. Enable pre-commit:

    ```bash
    pre-commit install
    ```

5. Compile the `dmp.pdf` file:

    ```bash
    stepup -n
    ```


## Contributions are welcome

If you would like to contribute, please read the general
[Guideline for Contribution to Reproducible Reporting](https://github.com/reproducible-reporting/.github/blob/main/CONTRIBUTING.md).
