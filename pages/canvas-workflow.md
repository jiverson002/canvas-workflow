---
title: "Canvas Workflow"
---

## Quick-Start

Create a folder with the following structure by downloading the appropriate
files.  

```
.
├── [.travis.yml]
├── README.md
├── [_config.yml]
├── ...
└── files
    └── ...
```

In the file named `_config.yml`, replace the url in the line `prefix:
"https://example.instructure.com"` with the url for your institution's Canvas
site. Likewise, in the line `course: 12345`, `12345` should be replaced with
your course id.  

[.travis.yml]: {% file download/.travis.yml %}
[_config.yml]: {% file download/_config.yml %}
