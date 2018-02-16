---
title: "TODO"
---

##### Canvas Workflow project
- [ ] Add documentation
  - [ ] Make GIFs of some of the useful things
    - [ ] Creating GitHub account
    - [ ] Creating Travis-CI account
    - [ ] Enable builds on a repo in Travis-CI
- [ ] Assignment overrides are the mechanism to set per section due dates
- [ ] Merge exclude/include keys from Jekyll space and Canvas space?
- [ ] Add a tabs key to yaml front-matter — when the key is present, tabbed
  navigation will be created
- [ ] Allow all due date information to be stored in a \_data/calendar.yml file
  or something like that
- [ ] Automatically? add canvas css classes for tables
- [ ] Create a separate branch for the gem, the master branch should be reserved
  for the documentation, so it can be an example of how to use Canvas Workflow.

##### CLI
- [x] Create a subcommand jekyll that handles jekyll related tasks
- [x] Create a subcommand push that pushes changes to the Canvas LMS \_site
  - [x] Use travis api and git diff to determine which files have changed since
    last successful build
    - Behavior will be undefined if the last successful build no longer exists
    - `git diff --diff-filter=??? —name-only SHA`
      - [ ] how to get the original file paths that have been renamed?
  - [x] upload files that have changed
  - [x] create new assignments
  - [ ] delete any files / assignments that have been removed
    - [ ] delete any directories that result from deleting files
- [x] Create a subcommand push that pushes changes to the Canvas LMS \_site
- [ ] Could provide commands like 'canvas assignment' to create a new assignment
  - [ ] this would involve creating a new assignment on canvas and getting the
    id, which it would insert into the assignment markdown file.
  - This would only be for "power users", since most users shouldn't even know
    of the existence of the gem.
- [x] Have commands create an artifact somewhere so that .travis.yml does not to
  explicitly manipulate the exit code

##### Liquid tags
- [x] Add a Liquid tag — to insert the html required by canvas to show a gist
- [x] Add a Liquid tag to dynamically get the id of a file, so that it can be
  used in the yaml for the api calls
  - [x] This requires that any new files are uploaded before Jekyll is run
- [ ] Add a Liquid tag to dynamically get the url of an assignment, so that it
  can be used in a link in markdown
  - [x] This requires that any new assignments are created before Jekyll is run
- [ ] Add a date-time tag, that will compute a date / time as a function of the
  course / section time
  - Useful for computing assignment due dates or events for the course

##### Tests
- [x] Create tests for Liquid tags
- [ ] Create tests for Jekyll theme
- [ ] Create tests for subcommands
  - [ ] push
  - [ ] jekyll build
  - [ ] deploy

##### Travis
- [x] Update Travis to build and push canvas-workflow gem when a
  tagged commit is pushed.
- [ ] Fix travis.yml to build and push canvas-workflow gem when a tagged
  commit is pushed.
- [ ] Use incremental option for Jekyll, then cache \_site directory to speed up
  builds?
