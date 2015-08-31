This is my (admittedly poor) attempt to automate generating a bunch of PDFs from
reStructuredText.

To use it,

1. Add it as a submodule in your git repository::

    $ git submodule add https://github.com/iamthememory/rst-latex-template

2. Then, copy ``rst-latex-template/recur-Makefile`` to whichever directories you
   want to recurse from::

    $ cp rst-latex-template/recur-Makefile Makefile

3. Edit the ``SUBDIRS`` line in those ``Makefile``\ s to contain the directories
   to recurse into. ::

    SUBDIRS = homework notes

4. Edit the ``TEXCLASSDIR`` line in at least the top-level ``Makefile`` to refer
   to the path of ``rst-latex-template`` relative to that ``Makefile``. ::

    TEXCLASSDIR = ./rst-latex-template

5. Link ``Makefile`` in each directory of reStructuredText files to
   ``rst-latex-template/rst-Makefile``. ::

    $ ln -rs rst-latex-template/rst-Makefile notes/Makefile

6. Link ``.gitignore`` in each directory of reStructuredText files to
   ``rst-latex-template/gitignore``. ::

    $ ln -rs rst-latex-template/gitignore notes/.gitignore
