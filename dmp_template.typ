// Template formatting
#set page(
  footer: context [
    #let (num,) = counter(page).get()
    #let (tot,) = counter(page).final()
    #text(fill: luma(50%), style: "italic", [
      #h(1fr)
      Page #num of #tot
    ])
  ]
)
#show link: it => { text(fill: blue, it) }

// Load data
#let fields = yaml("fields.yaml")
#let template = yaml("template.yaml")
#let generated = yaml("generated.yaml")

= Data Management Plan for "#fields.project_type: #fields.project_title"

== 1. Preamble

This data management plan is derived from the
#link("https://github.com/" + template.github_owner + "/" + template.github_repository + "/")[DMP template for StepUp-based projects]
version #template.version (#generated.template_current),
which is based on the Generic DMP+ template from
#link("https://dmponline.be")[DMP Online].
The first version of this template was created on 20 May 2024
and it was last updated on #generated.template_latest (at the time of writing).

This document dates from #generated.fields_current.
The source material of the latest version of this document can be found at:
#link("https://github.com/" + fields.github_owner + "/" + fields.github_repository + "/").

== 2. Project information

*Title:* #fields.project_title

*Start date:* #fields.project_start

*End date:* #fields.project_end

*Abstract:*

#eval(fields.project_abstract, mode: "markup")

*Grant:* #link(fields.grant_url)[#fields.grant_number]


== 3. Relevant Persons and Services

=== Persons involved

The following persons are involved in the project:

#table(
  columns: (1fr, 1fr, 1fr, auto, auto),
  align: center,
  table.header(
    [*Name (email)*],
    [*Role*],
    [*ORCID*],
    [*L*],
    [*A*],
  ),
  ..for record in fields.persons {(
    link("mailto:" + record.email, [#record.name]),
    [#record.role],
    if record.orcid != none {link("https://orcid.org/" + record.orcid, record.orcid)},
    if record.live == "yes" [✔],
    if record.archive == "yes" [✔],
  )}
)

- The column "L" indicates whether the person has access to the *live data*.
- The column "A" indicates whether the person has access to the *long-term archived data*
  after the project has ended.

=== Services used

- University storage:

  #eval(fields.university_storage, mode: "markup")

- High-performance clusters:

  #eval(fields.hpc, mode: "markup")

- Online collaboration and sharing:

  - #link("https://github.com/")[GitHub] is used for storing and sharing data
    in Git repositories between all researchers with access to live data.
  - #link("https://figshare.com/")[FigShare] and #link("https://zenodo.org/")[Zenodo]
    are used for long-term preservation and sharing of completed datasets.

== 4. Data Collection

=== What data will you create, collect or reuse?

/*
Relevant aspects:
- data types
- data volumes
- data formats
  - suitable for our purpose: collection, creation, analysis?
  - suitable for reuse: general, long-term?
*/

Two categories of new data will be created or reused:

1. Raw datasets generated by experimental measurements and/or computer simulations.

  #eval(fields.raw_data_what, mode: "markup")

  The file formats are chosen to facilitate data re-use:

  - All formats are widely used and can be read, written and processed by open source software.
  - Text-based formats are used as much as possible.
  - Python source code will be written and combined with existing open source software
    to perform all computations.
    Python is one of the most popular and open source programming languages,
    and it runs on practically any computer.

  The size of these datasets depends on the details of each work package.
  They can vary from a few GB to a few TB.

2. Publication source materials

  - Relevant publication data extracted from the post-processing steps of the raw datasets.
  - LaTeX and/or Typst sources (manuscripts, supporting information, cover letters, reply letters, etc.)
  - Python source code to perform additional analyses, generate figures (SVG, PDF) and tables (TEX, TYP, CSV) for inclusion in publications.
  - Workflows to facilitate a complete reproduction of the manuscript from its sources.
    (#link("https://reproducible-reporting.github.io/stepup-core/")[StepUp] `plan.py` scripts)

  The file formats are selected to facilitate data reuse,
  using the same strategy as for raw data sets.
  (See previous point.)

  The volume of data in a single publication depends strongly on the amount of post-processed data included in the Publication source.
  It can vary from a few MB to a few GB.

General recommendations for file formats and related good practices can be found in the
#link("https://reproducible-reporting.github.io/stepup-reprep/advanced_topics/good_practices/")[StepUp RepRep documentation].


=== How will the data be collected, created or reused?

/*
Relevant aspects:
- how is data created by hand?
- how is raw data captured or computed?
- how is existing data reused
- how is data organized, overall structure?
- version management
- quality assurance
*/

All datasets contain manually curated source data to some extent,
such as Python scripts, simulation input files and/or LaTeX documents.
Therefore, each dataset (either for raw data or for publications)
is contained in a Git repository to track the history of the source files
and to share these source files with everyone involved in the project.

Source data files are edited as follows:

- Text-based source files are manually created in Integrated Development Environments (IDEs),
  such as PyCharm and VSCode.
- Manually drawn figures are created using Inkscape (SVG files).

Quality assurance is implemented at several levels:

- Contributions to datasets are reviewed by someone with access to the live data.
- Simulations and custom analysis scripts are supplemented with validation functions,
  such as unit tests, to verify their correctness.

If the simulated or measured data is too large in volume to be included in the Git repository,
it must be shared by others means,
in such a way that all involved researchers
(involved in the project or external collaborators)
have access to the latest version.
To ensure a smooth integration with the Git repository,
non-Git data is shared as follows:

- It is stored on an SSH server that can be accessed by all participating researchers.
- The remote dataset can be mounted as a local subdirectory in the Git repository using SFTP.
- The Git repository contains all the tools to integrate the external dataset,
  such as scripts to mount and unmount the subdirectory.
- Any information or data needed to reconstruct the external data from scratch
  is included in the Git repository.

== 5. Data Documentation and Metadata

=== How will you document the data?

/* Relevant aspects:
- How do you make data directly interpretable?
- Standards in the field?
*/

For Python source code, we follow best practices for documentation:

- API documentation in docstrings.
- Source code comments to explain the intent of each piece of code.
- Where relevant, end-user documentation and/or tutorials written with
  #link("https://www.mkdocs.org/")[MkDocs] or #link("https://www.sphinx-doc.org/")[Sphinx].

Numerical datasets are accompanied by Markdown documents:

- To describe the meaning of columns in CSV files in plain English.
- To describe the meaning of arrays in NPY, NPZ, or ZAR files in plain English.

For all data, we also include the following per Git repository:

- A `README.md` file written in Markdown with:

    - An overview of the dataset, with links to the most important parts.
    - Instructions on how to reproduce and reuse the data.
    - The license under which the data is distributed.
    - A description of how different versions of the data are managed.

- A `CHANGELOG.md` file, following the
  "#link("https://keepachangelog.com/")[Keep a Changelog]" format.
  This file should provide an easily readable history of the dataset.
  It should be more condensed and transparent than the output of `git log`.


== 6. Ethical and Legal issues

=== Are you collecting or processing personal data?

/*
If you would like to answer "Yes" to this question, this template is not suitable for you.
This template does not provide details for handling personal or privacy-sensitive data.
*/

No.

=== How will you manage any ethics and confidentiality issues?

/*
Relevant aspects:
- Confidential data?
- If yes, how transfer and store if securely?
*/

- This project does not involve personal data nor other ethically sensitive data.
  All data are either measurements from inanimate experiments or results of computer simulations.
- None of the data in this project is subject to confidentiality restrictions.


=== How will you manage intellectual property rights issues?

/*
Relevant aspects:
- Data rights?
- License for reuse of generated data?
- License for reuse of external data?
- Embargos or restrictions related to patents?
*/

- Data generated in this project will be made available under
  a #link("https://creativecommons.org/")[Creative Commons] license
  to encourage others to reuse our data.
- The reusable Python source code will be made available as open source software,
  either as a package distributed on PyPI,
  or by including scripts and utilities associated with datasets
  deposited in appropriate online repositories.
  (More details on data deposits are given below.)
- The original authors retain the copyrights of the data they generate,
  unless these rights are transferred in an article publication agreement.


== 7. Data Storage and Backup during research

=== How will you store and backup data during research?

/*
Relevant aspects:
- where stored?
- sufficient resources?
- backup strategy?
- recovery process?
*/

While the research is in progress, live data will reside on laptops, workstations and user accounts of participating researchers on high-performance clusters.

The source material from which the data are generated is version controlled in Git repositories,
with remote storage on #link("https://github.com")[GitHub].
This online service has built-in reliable storage for ongoing projects.
All researchers involved in the project have local "clones" of all these repositories,
providing a sufficient level of redundancy of local copies.
To prevent corruption of the online copy,
Git branch protection rules are enforced to avoid accidental data loss due to human error.

Results derived from the source material,
through compilation, post-processing scripts or simulation software,
are stored locally or on high-performance clusters.
If the datasets are too large in volume or too expensive to recompute locally,
they are stored on an SSH server to which all researchers on the project have access.
For security reasons, key-based authentication is used with sufficiently long key pairs.

Periodic snapshots (#link("https://btrfs.readthedocs.io/")[BTRFS])
and periodic remote backups (#link("https://www.borgbackup.org/")[Borg])
are taken to protect against data loss due to hardware failures or human errors.
These tools have standard techniques for data recovery in the event of an incident.
#link("https://github.com/reproducible-reporting/backup-script")[Our backup script] is made publicly available.

When a project deliverable is completed, the corresponding data is archived for long-term storage.
For publications, StepUp RepRep provides
#link("https://reproducible-reporting.github.io/stepup-reprep/advanced_topics/archive_git/")[an archival protocol],
which can be followed.
This protocol is easily generalized to other datasets in this project.


=== How will you ensure that stored data are secure?

/*
Relevant aspects:
- identify risks
- access control and authorization
- secure transfer
*/

We aim to maximize the openness of the data produced in this work.
The main risk is unintentional data loss, either by human error or technical problems.
To reduce the risk of such data incidents,
Git is used for version control and secure communication
and authentication protocols are used to give write access only to the appropriate people.

Good data security practices are followed,
the details of which depend on where the data is stored:

- GitHub has fine-grained access control options
  and uses SSH or HHTPS protocols for encrypted communications.
- University storage servers also have fine-grained access controls.
- Data stored on high-performance clusters are accessed through the SSH protocol.
  The default Unix file permissions are strict to rule out unauthorized access.

Our default protocol for data exchange is SSH, which is the industry standard for encrypted communication.

The integrity of datasets after a transfer is validated using
#link("https://reproducible-reporting.github.io/stepup-reprep/advanced_topics/inventory_files/")[StepUp RepRep inventory files].


== 8. Data Selection and Preservation after Research

=== Which data should be retained for preservation and/or sharing?

/*
Relevant aspects:
- must data be destroyed?
- what to keep, why and for how long
*/

As a rule, all data generated in this project can and will be preserved.
Exceptions are only made when the following two conditions are met:

- Larger volumes of data that can be reconstructed at a relatively low cost.
- The implementation that can regenerate the data is archived and can be run again.

#eval(fields.data_lifetime, mode: "markup")


=== What is the long-term preservation plan for the selected datasets?

/*
Relevant aspects:
- deposit in repository or archive? (yes/no)
- costs?
- curation required after end of project?
*/

Data will be preserved as follows:

- *Publications:*
  All source materials and workflows for reproducing publications will be created with #link("https://reproducible-reporting.github.io/stepup-reprep/")[StepUp RepRep],
  which has built-in protocols for creating long-term archives.
  These archives will be stored for at least 10 years on university-provided storage servers,
  in two forms as documented in the
  #link("https://reproducible-reporting.github.io/stepup-reprep/advanced_topics/archive_git/")[StepUp RepRep Archiving Tutorial]:

    - A #link("https://git-scm.com/docs/git-bundle")[Git bundle] of the full history of the source files.
    - A ZIP file of the most recent version, including source files and all built output files
      (PDF preprint of the publication, etc.)

- *Reusable individual elements from the publications:*

    - Individual figures and tables from publications are uploaded to FigShare.
    - Data presented in figures and tables are also uploaded in reusable form on FigShare,
      e.g. as documented CSV files.
    - SVG source files of figures are also uploaded to FigShare when available.

    FigShare does not currently have a data lifetime limit.

    (The development of a convenient tool for uploading such data efficiently is foreseen in StepUp RepRep.)

- *Large raw datasets:*
  will be stored on Zenodo, which currently has no limitation on the data lifetime.

All of the archives discussed above will be created after a deliverable has been completed.
Therefore, these data will not change after publication and will not require additional curation.

The free tiers of the remote storage services are suitable for the datasets in this work.


== 9. Data Sharing

=== Are any restrictions on data sharing required?

/* This mostly relevant for personal or confidential data, not used here. */

The only restrictions are those of
the #link("https://creativecommons.org/")[Creative Commons]
or #link("https://opensource.org/")[open-source license]
used to share the datasets.


=== How will you share data selected for sharing?

/*
Relevant aspects:
- When
- Where
- How make it FAIR?
- DOI?
*/

Data will be made available through public data repositories (see above) upon completion of a project deliverable.
These repositories support rich metadata to make the data discoverable through built-in search functions or popular search engines.
They also provide DOIs for uploaded datasets.

Live datasets are only shared among researchers working on the project
or collaborators involved in the project using the means described above.


== 10. Responsibilities and Resources

=== Who will be responsible for data management?

/*
Relevant aspects:
- Who periodically updates DMP? How often?
- Who implements DMP?
- How is the work divided?
- What is people leave?
*/

The PIs overseeing the project will update the data management plan,
with the active participation from all researchers involved in the project.

Archiving for long-term preservation will be carried out by the PIs and persons with long-term appointments,
as they may be given permissions to access the data after the project has ended.

Data management is a shared responsibility,
which we will implement by using software tools to facilitate good practices from the start of each dataset.
By having everyone work with compatible tools,
we constantly validate the adherence to our data management protocol.

Data placed in public repositories will remain available after researchers change positions.
Only for data hosted on UGent project shares,
a series of persons must be given access permissions
to guarantee that the data remains available over a sufficiently long time:
the researchers involved in the project
and at least one other tenured staff member outside the project.


=== Will you need additional resources to implement your DMP?

/*
Relevant aspects:
- training
- resources (hardware, software, subscriptions, ...)
*/

We rely on online services for long-term storage (GitHub, FigShare, Zenodo),
which have sufficiently resourceful free tiers.
In addition, university-provided storage is available at no cost.
The PIs have the necessary expertise to implement the data management plan
and will transfer the required knowledge and skills to other persons involved in the project.
