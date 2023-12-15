# -*- coding: utf-8 -*-

project = u'atmanager'
copyright = u'2016, Vladimir Roncevic <elektron.ronca@gmail.com>'
author = u'Vladimir Roncevic <elektron.ronca@gmail.com>'
version = u'4.0'
release = u'https://github.com/vroncevic/atmanager/releases'
extensions = []
templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'
language = None
exclude_patterns = []
pygments_style = None
html_theme = 'classic'
html_static_path = ['_static']
htmlhelp_basename = 'atmanagerdoc'
latex_elements = {}
latex_documents = [(
    master_doc, 'atmanager.tex', u'atmanager Documentation',
    u'Vladimir Roncevic \\textless{}elektron.ronca@gmail.com\\textgreater{}',
    'manual'
)]
man_pages = [(
    master_doc, 'atmanager', u'atmanager Documentation', [author], 1
)]
texinfo_documents = [(
    master_doc, 'atmanager', u'atmanager Documentation', author, 'atmanager',
    'One line description of project.', 'Miscellaneous'
)]
epub_title = project
epub_exclude_files = ['search.html']
