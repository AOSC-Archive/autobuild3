Contributing
============

autobuild3 follows some issue-driven development.

Issues
------

First of all, update to the latest tag. If it doesn't work, update to Git master.

Write descriptive text, give nice (better if minimal) reproductions for bugs
and good documentation for pending features.

Pull Requests
-------------

Always, write `module/file[, ...]: msg` as title and add extra stuffs below,
with a blank line as spacing so git (and hub) will take it as descriptions.
Sign-Off should NOT be used in regular commits or you are flooding our
Channel.

Workflow
--------

Git workflow without minor version branches and development branches. Using
patch version branches is more than insane, so omitted.

Versioning
----------

Tags only. Prefix the tagname with `v` for versions.

If you are really happy, change a file like `autobuild/defines` and create a
commit like this:

```Markdown
ab/defines: bumping to version v0.1.4

Issues and PRs: #17, #18, #24, #11, AOSC-Dev/abbs#4, ......

<!-- Oh yes you can make it like this: -->
- #17: a short title
- #18: a manually shortened title
- #24: ...

Major Changes:

- Deprecated use of `USEQT4`, ........

```

and when you publish the release with this commit, the release text will
be automatically filled with the description. All you need is to clear the
title.

Doing so allow people to see your release log offline, in git.
