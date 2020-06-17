# Apache Tomcat Manager.

**atmanager** is shell tool for controlling/operating Apache Tomcat Server.

Developed in [bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) code: **100%**.

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

[![GitHub issues open](https://img.shields.io/github/issues/vroncevic/atmanager.svg)](https://github.com/vroncevic/atmanager/issues)
 [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/atmanager.svg)](https://github.com/vroncevic/atmanager/graphs/contributors)

<!-- START doctoc -->
**Table of Contents**

- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Shell tool structure](#shell-tool-structure)
- [Docs](#docs)
- [Copyright and Licence](#copyright-and-licence)
<!-- END doctoc -->

### INSTALLATION

Navigate to release [page](https://github.com/vroncevic/atmanager/releases) download and extract release archive.

To install modules type the following:

```
tar xvzf atmanager-x.y.z.tar.gz
cd atmanager-x.y.z
cp -R ~/sh_tool/bin/   /root/scripts/atmanager/ver.1.0/
cp -R ~/sh_tool/conf/  /root/scripts/atmanager/ver.1.0/
cp -R ~/sh_tool/log/   /root/scripts/atmanager/ver.1.0/
```

![alt tag](https://raw.githubusercontent.com/vroncevic/atmanager/dev/docs/setup_tree.png)

Or You can use docker to create image/container.

### USAGE

```
# Create symlink for shell tool
ln -s /root/scripts/atmanager/ver.1.0/bin/atmanager.sh /root/bin/atmanager

# Setting PATH
export PATH=${PATH}:/root/bin/

# Start Apache Tomcat
atmanager start
```

### DEPENDENCIES

**atmanager** requires next modules and libraries:
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### SHELL TOOL STRUCTURE

**atmanager** is based on MOP.

Code structure:
```
.
├── bin/
│   └── atmanager.sh
├── conf/
│   ├── atmanager.cfg
│   └── atmanager_util.cfg
└── log/
    └── atmanager.log
```

### DOCS

[![Documentation Status](https://readthedocs.org/projects/atmanager/badge/?version=latest)](https://atmanager.readthedocs.io/projects/atmanager/en/latest/?badge=latest)

More documentation and info at:
* [https://atmanager.readthedocs.io/en/latest/](https://atmanager.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)
* [http://tomcat.apache.org/tomcat-9.0-doc/introduction.html](http://tomcat.apache.org/tomcat-9.0-doc/introduction.html)

### COPYRIGHT AND LICENCE

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2017 by [vroncevic.github.io/atmanager](https://vroncevic.github.io/atmanager)

This tool is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

