---
title: "Canvas Workflow"
---

## Quick-Start Guide

The basic folder structure for a Canvas Workflow site is shown below. The only
two files that must be present in a Canvas Workflow site are `.travis.yml` and
`_config.yml`; starter versions of these two files can be downloaded from
[here][.travis.yml] and [here][_config.yml] respectively.       

```
site
├── .travis.yml
├── README.md
├── _config.yml
├── ...
├── assignments
│   └── ...
├── files
│   └── ...
└── pages
    └── ...
```

### Configuration

A Canvas Workflow site must be configured to point to the correct Canvas LMS
XXX. In the file named `_config.yml`, replace
`"https://example.instructure.com"` in the line

```yaml
prefix: "https://example.instructure.com"
```

with the url of your institution's Canvas LMS site. Likewise, in the line

```yaml
course: 12345
```

`12345` should be replaced with your course id.  

#### Selecting which files to upload

By default, all files in a Canvas Workflow site that are contained in the
`files` folder or any of its sub-folders, will be uploaded to the  Canvas site.
Sometimes it is convenient to include files in the `files` folder that should
not be uploaded to the Canvas site. In these cases, it is possible to direct the
Canvas Workflow engine to exclude certain files/folders when uploading. To do
this, list them in your `_config.yml` file using the `exclude` key, like so:  

```yaml
canvas:
  ...
  exclude:
    - CHANGELOG.md
    - LICENSE
    - files/slides
```

where `CHANGELOG.md` and `LICENSE` are both files and `files/slides` is a
folder. In this example, the two files will not be uploaded, nor will the
`files/slides` folder or any of its contents.   

If a folder is listed under the `exclude` key, but there are some files
contained within it that should be uploaded, simply list the files/folders you
would like uploaded under the `include` key, like so:

```yaml
canvas:
  ...
  include:
    - files/slides/intro.pdf
```

which, along with the previous example, would exclude anything contained within
the folder `files/slides` and its sub-folders, except for the file
`files/slides/intro.pdf`.

**Rationale** The precedence given to `include` over `exclude` is the result of
the desire to keep source files --- those files used to generate material that
is ultimately uploaded to the Canvas site --- in the same Git repository as the
other Canvas site material. By allowing the exclusion of entire directories
along with the option to selectively re-include certain files/folders, this is
relatively convenient.

**Advanced usage** It is possible to use [file globbing] when listing
files/folders. The glob pattern must satisfy the requirements found
[here][dir.glob].

[.travis.yml]: https://raw.githubusercontent.com/jiverson002/canvas-workflow/site/.travis.yml
[_config.yml]: https://raw.githubusercontent.com/jiverson002/canvas-workflow/site/_config.yml
[file globbing]: https://en.wikipedia.org/wiki/Glob_%28programming%29
[dir.glob]: https://ruby-doc.com/core/Dir.html#method-c-glob
