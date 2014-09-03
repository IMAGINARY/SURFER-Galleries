Galleries of the SURFER program
===============================

This repository contains the LaTeX sources of the galleries that come with the [SURFER](http://imaginary.org/program/surfer/) program. They consist of a tutorial gallery, a gallery containing so-called world record surfaces (i.e. surfaces with many singularities) and a galleriy with surfaces which are just nice (fantasy surfaces).

The galleries have already been translated to various languages other then the English and German. Translations to additional languages as well as improvements of existing translations are highly welcome.

Compiling the LaTeX sources to PDF
----------------------------------

First of all, you need to install a TeX distribution like [TeXLive](https://www.tug.org/texlive/) or [MikTeX](http://www.miktex.org/). It is highly recommended to install the full distribution (all available packages). This usually causes the least trouble. If you only installed a TeX base system, you may need to install additional packages (at least `xelatex` and all the packages listed within `\RequirePackage` commands in `common/SurferDesc.cls` respectively `common/SurferDescCJK.cls`). For MikTeX, you also need to download the [sfmath package](http://www.ctan.org/tex-archive/macros/latex/contrib/sfmath/sfmath.sty) and put it somewhere LaTeX can find it (for some reason, `sfmath` is not part of the MikTeX distribution).

Choose a gallery and a language to compile, e.g. `fantasy` (fantasy surfaces) and `en` (English). Change to the appropriate directory:
```
cd fantasy/en
```

The main LaTeX file is always `galleryname_language.tex`, e.g. `fantasy_en.tex`. Compile it using
```
xelatex --shell-escape fantasy_en.tex
```

The other files in the respective folder are included by the main file. There is no need to touch them.

You may need to repeat the compilation several times until all references and hyperlinks are resolved.

If you are on a Unix-like system you may also call the `compile_all.sh` bash script in the top folder to create all gallery PDFs in all languages. This needs `latexmk` to be installed on your system.

Contributions
-------------

### Adding a new translation

### Improving existing translations

License
-------

The gallery files and its sources are released under the `TODO` license. For details see the `LICENSE` file. By contributing to this project you automatically accepts that your contributions will be released under the same license terms.

Authors
-------

See the ```AUTHORS``` file.
