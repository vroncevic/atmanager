# Apache Tomcat Manager

<img align="right" src="https://raw.githubusercontent.com/vroncevic/atmanager/dev/docs/atmanager_logo.png" width="25%">

**atmanager** is shell tool for controlling/operating **[Apache Tomcat Server](http://tomcat.apache.org/index.html)**.

Developed in **[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))** code: **100%**.

[![atmanager_shell_checker](https://github.com/vroncevic/atmanager/actions/workflows/atmanager_shell_checker.yml/badge.svg)](https://github.com/vroncevic/atmanager/actions/workflows/atmanager_shell_checker.yml)

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

![Debian Linux OS](https://raw.githubusercontent.com/vroncevic/atmanager/dev/docs/debtux.png)

Navigate to release **[page](https://github.com/vroncevic/atmanager/releases)** download and extract release archive.

To install **atmanager** type the following

```bash
tar xvzf atmanager-5.0.tar.gz
cd atmanager-5.0
cp -R ~/sh_tool/bin/   /root/scripts/atmanager/ver.5.0/
cp -R ~/sh_tool/conf/  /root/scripts/atmanager/ver.5.0/
cp -R ~/sh_tool/log/   /root/scripts/atmanager/ver.5.0/
```

Self generated setup script and execution

```bash
./atmanager_setup.sh 

[setup] installing App/Tool/Script atmanager
	Tue Dec  2 07:09:46 PM CET 2025
[setup] clean up App/Tool/Script structure
[setup] copy App/Tool/Script structure
[setup] remove github editor configuration files
[setup] set App/Tool/Script permission
[setup] create symbolic link of App/Tool/Script
[setup] done

/root/scripts/atmanager/ver.5.0/
├── bin/
│   └── atmanager.sh
├── conf/
│   ├── atmanager.cfg
│   ├── atmanager.logo
│   └── atmanager_util.cfg
└── log/
    └── atmanager.log

4 directories, 5 files
lrwxrwxrwx 1 root root 48 Dec  2 19:09 /root/bin/atmanager -> /root/scripts/atmanager/ver.5.0/bin/atmanager.sh
```

Or You can use docker to create image/container.

### Usage

```bash
# Create symlink for shell tool
ln -s /root/scripts/atmanager/ver.5.0/bin/atmanager.sh /root/bin/atmanager

# Setting PATH
export PATH=${PATH}:/root/bin/

# Start Apache Tomcat Server
atmanager start

atmanager ver.5.0
Tue Dec  2 07:09:46 PM CET 2025

[check_root] Check permission for current session? [ok]
[check_root] Done

                                                                                     
               ██                                                                    
              ░██                                                                    
    ██████   ██████ ██████████   ██████   ███████   ██████    █████   █████  ██████  
   ░░░░░░██ ░░░██░ ░░██░░██░░██ ░░░░░░██ ░░██░░░██ ░░░░░░██  ██░░░██ ██░░░██░░██░░█  
    ███████   ░██   ░██ ░██ ░██  ███████  ░██  ░██  ███████ ░██  ░██░███████ ░██ ░   
   ██░░░░██   ░██   ░██ ░██ ░██ ██░░░░██  ░██  ░██ ██░░░░██ ░░██████░██░░░░  ░██     
  ░░████████  ░░██  ███ ░██ ░██░░████████ ███  ░██░░████████ ░░░░░██░░██████░███     
   ░░░░░░░░    ░░  ░░░  ░░  ░░  ░░░░░░░░ ░░░   ░░  ░░░░░░░░   █████  ░░░░░░ ░░░      
                                                             ░░░░░                   
	                                                       
		Info   github.io/atmanager ver.5.0 
		Issue  github.io/issue
		Author vroncevic.github.io

[atmanager] Loading basic and util configuration!
100% [================================================]

[load_conf] Loading App/Tool/Script configuration!
[check_cfg] Checking configuration file [/root/scripts/atmanager/ver.5.0/conf/atmanager.cfg] [ok]
[check_cfg] Done

[load_conf] Done

[load_util_conf] Load module configuration!
[check_cfg] Checking configuration file [/root/scripts/atmanager/ver.5.0/conf/atmanager_util.cfg] [ok]
[check_cfg] Done

[load_util_conf] Done

[check_tool] Checking tool [/opt/tomcat/bin/catalina.sh]? [ok]
[check_tool] Done

[check_op] Checking operation [start]? [ok]
[check_op] Done

[atmanager] Operation: start Apache Tomcat Server
Using CATALINA_BASE:   /opt/tomcat
Using CATALINA_HOME:   /opt/tomcat
Using CATALINA_TMPDIR: /opt/tomcat/temp
Using JRE_HOME:        /usr
Using CLASSPATH:       /opt/tomcat/bin/bootstrap.jar:/opt/tomcat/bin/tomcat-juli.jar
Using CATALINA_OPTS:   
Tomcat started.
[logging] Checking directory [/root/scripts/atmanager/ver.5.0/log/]? [ok]
[logging] Write info log!
[logging] Done

[atmanager] Done
```

### Dependencies

**atmanager** requires next modules and libraries
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### Shell tool structure

**atmanager** is based on MOP.

Shell tool structure

```bash
sh_tool/
├── bin/
│   └── atmanager.sh
├── conf/
│   ├── atmanager.cfg
│   ├── atmanager.logo
│   └── atmanager_util.cfg
└── log/
    └── atmanager.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/atmanager/badge/?version=latest)](https://atmanager.readthedocs.io/projects/atmanager/en/latest/?badge=latest)

More documentation and info at
* [https://atmanager.readthedocs.io/en/latest/](https://atmanager.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)
* [http://tomcat.apache.org/tomcat-9.0-doc/introduction.html](http://tomcat.apache.org/tomcat-9.0-doc/introduction.html)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2016 - 2026 by [vroncevic.github.io/atmanager](https://vroncevic.github.io/atmanager)

**atmanager** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

[![Free Software Foundation](https://raw.githubusercontent.com/vroncevic/atmanager/dev/docs/fsf-logo_1.png)](https://my.fsf.org/)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://my.fsf.org/donate/)
