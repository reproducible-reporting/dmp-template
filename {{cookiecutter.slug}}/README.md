[![Creative Commons License](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

This work is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](http://creativecommons.org/licenses/by-nc-sa/4.0/).


# Data Management Plan "{{ cookiecutter.short_name }}"

This repository contains the version history of the data management plan for the project:

> {{ cookiecutter.long_name }}

To rebuild and work on the data management plan, `dmp.pdf`,
you need to set up the repository as follows:

```bash
git clone git@github.com:reproducible-reporting/{{ cookiecutter.slug }}.git
cd {{ cookiecutter.slug }}
./setup-venv-pip.sh
pre-commit install
stepup -n
```

This is a living document of which the latest Git commit contains the most up-to-date information.
No version numbers are assigned.
