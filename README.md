# Neat CV

**Neat CV** is a set of templates to produce modern, minimal and elegant CVs and cover letters using [Typst](https://github.com/typst/).

This project is an adaptation of the very nice [Brilliant CV](https://github.com/mintyfrankie/brilliant-CV) project, with inspiration from the LaTeX template [Alta CV](https://fr.overleaf.com/latex/templates/altacv-template/trgqjpwnmtgv) or [its Typst equivalent](https://github.com/GeorgeHoneywood/alta-typst).

Document examples can be found in the `output` directory.

## Features

The set of available features is about the same as [Brilliant CV](https://github.com/mintyfrankie/brilliant-CV)'s.

- **Style and content separation**: The documents' contents is defined in the `src/modules` directory, and can be changed independently of the styling.
- **Multilingual support**: Define different versions of your documents in your `src/modules` directory, and configure the targeted language at compilation in `src/metadata.typ`.

Some additional features included but not shown in the example documents are **company and organization logos**, as well as **choosing whether to display the title or the organization's name first in a CV entry**.


## Getting started

### Installation

Everything needed to use the templates is contained in the `src` directory.

You may clone this repository and modify the files directly, or you can copy the `src` directory into an existing Typst project. Any part of the templates can then be modified according to your needs and desires.


## Usage

### Compile documents

Use the following `typst` commands to produce the documents from the templates.

```bash
typst compile src/cv.typ path/to/cv.pdf --font-path src/fonts/
typst compile src/letter.typ path/to/letter.pdf --font-path src/fonts/
```


## License

Distributed under the MIT License.
