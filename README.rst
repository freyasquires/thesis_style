Freya's PhD Thesis LaTeX class
==============================

This repository contains the class file ``fsthesis.cls`` and some example files that show how to use it.

To compile the example;

.. code-block:: console

	$ pdflatex thesis_example.tex
	$ bibtex thesis_example
	$ makeglossaries thesis_example
	$ pdflatex thesis_example.tex
	$ pdflatex thesis_example.tex

