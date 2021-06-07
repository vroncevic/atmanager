<img align="right" src="https://raw.githubusercontent.com/vroncevic/atmanager/dev/docs/atmanager_logo.png" width="25%">

# Apache Tomcat Manager

**atmanager** is shell tool for controlling/operating **[Apache Tomcat Server](http://tomcat.apache.org/index.html)**.

Developed in **[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))** code: **100%**.

[![atmanager shell checker](https://github.com/vroncevic/atmanager/workflows/atmanager%20shell%20checker/badge.svg)](https://github.com/vroncevic/atmanager/actions?query=workflow%3A%22atmanager+shell+checker%22)

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

[![GitHub issues open](https://img.shields.io/github/issues/vroncevic/atmanager.svg)](https://github.com/vroncevic/atmanager/issues) [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/atmanager.svg)](https://github.com/vroncevic/atmanager/graphs/contributors)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Shell tool structure](#shell-tool-structure)
- [Docs](#docs)
- [Copyright and licence](#copyright-and-licence)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### Installation

Navigate to release **[page](https://github.com/vroncevic/atmanager/releases)** download and extract release archive.

To install **atmanager** type the following:

```
tar xvzf atmanager-x.y.tar.gz
cd atmanager-x.y
cp -R ~/sh_tool/bin/   /root/scripts/atmanager/ver.x.y/
cp -R ~/sh_tool/conf/  /root/scripts/atmanager/ver.x.y/
cp -R ~/sh_tool/log/   /root/scripts/atmanager/ver.x.y/
```

![alt tag](https://raw.githubusercontent.com/vroncevic/atmanager/dev/docs/setup_tree.png)

Or You can use docker to create image/container.

[![atmanager docker checker](https://github.com/vroncevic/atmanager/workflows/atmanager%20docker%20checker/badge.svg)](https://github.com/vroncevic/atmanager/actions?query=workflow%3A%22atmanager+docker+checker%22)

### Usage

```
# Create symlink for shell tool
ln -s /root/scripts/atmanager/ver.x.y/bin/atmanager.sh /root/bin/atmanager

# Setting PATH
export PATH=${PATH}:/root/bin/

# Start Apache Tomcat
atmanager start
```

### Dependencies

**atmanager** requires next modules and libraries:
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### Shell tool structure

**atmanager** is based on MOP.

Code structure:
```
sh_tool/
├── bin/
│   └── atmanager.sh
├── conf/
│   ├── atmanager.cfg
│   └── atmanager_util.cfg
└── log/
    └── atmanager.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/atmanager/badge/?version=latest)](https://atmanager.readthedocs.io/projects/atmanager/en/latest/?badge=latest)

More documentation and info at:
* [https://atmanager.readthedocs.io/en/latest/](https://atmanager.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)
* [http://tomcat.apache.org/tomcat-9.0-doc/introduction.html](http://tomcat.apache.org/tomcat-9.0-doc/introduction.html)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2016 by [vroncevic.github.io/atmanager](https://vroncevic.github.io/atmanager)

**atmanager** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

[![Free Software Foundation](https://raw.githubusercontent.com/vroncevic/atmanager/dev/docs/fsf-logo_1.png)](https://my.fsf.org/)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://my.fsf.org/donate/)
