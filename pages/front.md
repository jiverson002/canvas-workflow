---
title: "Canvas Workflow"
---

# Canvas Workflow

Welcome to your new Jekyll theme! In this directory, you'll find the files you
need to be able to package up your theme into a gem. Put your layouts in
`_layouts`, your includes in `_includes`, your sass files in `_sass` and any
other assets in `assets`.

To experiment with this code, add some sample content and run `bundle exec
jekyll serve` – this directory is setup just like a Jekyll site!

TODO: Delete this and the text above, and describe your gem

## Installation

```
.
├── .travis.yml
├── README.md
├── _config.yml
├── ...
└── files
    └── ...
```

Create a file called `_config.yml` with the following contents:

```yaml
# Canvas settings.
canvas:
  prefix: <your institution's canvas url here>
  course: <your course id here>

# Exclude the following files/folders from processing. Jekyll currently gives
# exclude precedence over include, so list files/folders not to be included
# here.
exclude:
  - files

################################################################################
####################   DO NOT CHANGE ANYTHING BELOW HERE!   ####################
################################################################################

# Use the canvas-workflow-jekyll theme to produce correctly formatted yaml files
# for use with the canvas-workflow-travis gem.
theme: canvas-workflow-jekyll

# Disable any plugins that are not explicitly enabled (whitelisted) below.
safe: true
# Allow the set of plugins included with the canvas-workflow-jekyll gem to
# provide useful tags for the Canvas LMS.
whitelist:
  - canvas-workflow-jekyll
plugins:
  - canvas-workflow-jekyll

# Render pages, even those marked unpublished --- this allows a page to be
# rendered and uploaded, but marked as not published on Canvas, if
# [published: false] appears in the yaml front matter.
unpublished: true

# Disable syntax highlighting.
highlighter: none

# Fail build if there is incorrect yaml front matter.
strict_front_matter: true

# Set the default layouts for certain types of files.
defaults:
  - scope:
      path: "README.md"
    values:
      layout: syllabus
  - scope:
      path: "assignments"
    values:
      layout: assignment
  - scope:
      path: "pages"
    values:
      layout: page
```

and create a file called `.travis.yml` with the following contents:

```yaml
# Tell Travis the project language.
language: ruby

# Route to the container-based infrastructure for a faster build.
sudo: false

# Enable caching the bundle between builds.
cache: bundler

# Branch whitelist.
branches:
  only:
    - master

# The order of the steps below is significant.
script:
  # initialize environment
  - EXITCODE=0 ; (exit $EXITCODE)
  # run RSpec tests
  - test $EXITCODE -eq 0 && bundle exec rspec ; EXITCODE=$? ; (exit $EXITCODE)
  # upload files to canvas
  - test $EXITCODE -eq 0 && bundle exec canvas-upload ; EXITCODE=$? ; (exit $EXITCODE)
  # build site
  - test $EXITCODE -eq 0 && bundle exec jekyll build --verbose ; EXITCODE=$? ; (exit $EXITCODE)
  # deploy site to canvas
  - test $EXITCODE -eq 0 && bundle exec canvas-deploy ; EXITCODE=$? ; (exit $EXITCODE)
```

## Usage

TODO: Write usage instructions here. Describe your available layouts, includes,
sass and/or assets.
