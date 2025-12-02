atmanager
----------

**atmanager** is shell tool for controlling/operating `Apache Tomcat Server <http://tomcat.apache.org/index.html>`_.

Developed in `bash <https://en.wikipedia.org/wiki/Bash_(Unix_shell)>`_ code: **100%**.

|GitHub shell checker|

.. |GitHub shell checker| image:: https://github.com/vroncevic/atmanager/actions/workflows/atmanager_shell_checker.yml/badge.svg
   :target: https://github.com/vroncevic/atmanager/actions/workflows/atmanager_shell_checker.yml

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

|GitHub issues| |Documentation Status| |GitHub contributors|

.. |GitHub issues| image:: https://img.shields.io/github/issues/vroncevic/atmanager.svg
   :target: https://github.com/vroncevic/atmanager/issues

.. |GitHub contributors| image:: https://img.shields.io/github/contributors/vroncevic/atmanager.svg
   :target: https://github.com/vroncevic/atmanager/graphs/contributors

.. |Documentation Status| image:: https://readthedocs.org/projects/atmanager/badge/?version=latest
   :target: https://atmanager.readthedocs.io/projects/atmanager/en/latest/?badge=latest

.. toctree::
    :hidden:

    self

Installation
-------------

|Debian Linux OS|

.. |Debian Linux OS| image:: https://raw.githubusercontent.com/vroncevic/atmanager/dev/docs/debtux.png
   :target: https://www.debian.org

Navigate to release `page`_ download and extract release archive.

.. _page: https://github.com/vroncevic/atmanager/releases

To install **atmanager** type the following

.. code-block:: bash

   tar xvzf atmanager-5.0.tar.gz
   cd atmanager-5.0
   cp -R ~/sh_tool/bin/   /root/scripts/atmanager/ver.5.0/
   cp -R ~/sh_tool/conf/  /root/scripts/atmanager/ver.5.0/
   cp -R ~/sh_tool/log/   /root/scripts/atmanager/ver.5.0/

Or You can use Docker to create image/container.

Dependencies
-------------

**atmanager** requires next modules and libraries

* sh_util `https://github.com/vroncevic/sh_util <https://github.com/vroncevic/sh_util>`_

Shell tool structure
---------------------

**atmanager** is based on MOP.

Shell tool structure

.. code-block:: bash

   sh_tool/
   ├── bin/
   │   └── atmanager.sh
   ├── conf/
   │   ├── atmanager.cfg
   │   ├── atmanager.logo
   │   └── atmanager_util.cfg
   └── log/
       └── atmanager.log

Copyright and licence
----------------------

|License: GPL v3| |License: Apache 2.0|

.. |License: GPL v3| image:: https://img.shields.io/badge/License-GPLv3-blue.svg
   :target: https://www.gnu.org/licenses/gpl-3.0

.. |License: Apache 2.0| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
   :target: https://opensource.org/licenses/Apache-2.0

Copyright (C) 2016 - 2026 by `vroncevic.github.io/atmanager <https://vroncevic.github.io/atmanager>`_

**atmanager** is free software; you can redistribute it and/or modify it
under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

|Free Software Foundation|

.. |Free Software Foundation| image:: https://raw.githubusercontent.com/vroncevic/atmanager/dev/docs/fsf-logo_1.png
   :target: https://my.fsf.org/

|Donate|

.. |Donate| image:: https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif
   :target: https://my.fsf.org/donate/

Indices and tables
------------------

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
