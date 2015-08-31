This is my (admittedly poor) attempt to automate generating a bunch of PDFs from
reStructuredText.
This was a relatively quick-and-dirty attempt to build PDFs for my school notes
in reStructuredText, so be warned that it is not very complete or robust.

To add it to your repository,

1. Add it as a submodule in your git repository::

    $ git submodule add https://github.com/iamthememory/rst-latex-template.git

2. Then, put the following in ``Makefile`` for each directory you want to
   recurse from::

    SUBDIRS = directory1 directory2
    include [path_to_rst-latex-template]/recurse.mk

3. Put the following in ``Makefile`` for each directory you want to build PDFs
   in::

    include [path_to_rst-latex-template]/build_rst.mk

4. Link ``.gitignore`` in each directory of reStructuredText files to
   ``rst-latex-template/gitignore``. ::

    $ ln -rs rst-latex-template/gitignore notes/.gitignore

Build the PDFs by running::

    $ make

You can remove all the junk used to generate the PDFs by running::

    $ make clean

If you want to get rid of all of the generated files, including the PDFs, run::

    $ make reallyclean
