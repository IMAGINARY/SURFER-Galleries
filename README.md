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

We encourage you to add translations for new languages and to improve existing ones. Note that by sending us your contributions you agree that they will be published under the license stated at the end of this file. 

Please read the entire guide before starting any action.

### Adding a new translation

First, look up your two-letter IETF BCP 47 language tag using [this search engine](http://rishida.net/utils/subtags/). 

Assume you want to translate from English (`en`) to Turkish (`tr`). (Replace `en` and `tr` with the tags that fit your needs). Now, for each gallery (`fantasy`, `record`, `tutorial`), create a copy of the `en` subfolder and rename it to `tr`.

Rename the main files of each galery to include the new language tag, e.g. rename
```
fantasy_en.tex  -> fantasy_tr.tex
record_en.tex   -> record_tr.tex
tutorial_en.tex -> tutorial_tr.tex
```

You have to edit these three files depending on the *type of language* you are translation from and to. Currently, every language supported by the `polyglossia` package should work as well as so called CJK languages (Chinese-Japanese-Korean). If your language is not in this list, please [report this issue](https://github.com/IMAGINARY/SURFER-Galleries/issues/new).

 1. non-CJK to non-CJK language: change the line `\setmainlanguage{...}` to reflect your language (see the [documentation](http://mirrors.ctan.org/macros/latex/contrib/polyglossia/polyglossia.pdf) of `polyglossia`)
 2. non-CJK to CJK language: change the document class from `SurferDesc` to `SurferDescCJK` and delete the `\setmainlanguage{...}` line
 3. CJK to CJK language: nothing to do 

Now you are ready to translate the galleries (all `.tex` files except the main file). Please keep your document structure and LaTeX source (math/figures) as close as possible to the other translations. We usually use a visual diff and merge tool to have the original and the new translation side by side. Using e.g. [meld](http://meldmerge.org/) it looks like this:

![Side-by-side editing using meld](https://raw.github.com/IMAGINARY/SURFER-Galleries/gh-pages/images/meld.png "Side-by-side editing using meld")

Using the side-by-side editing also avoids many common erros, e.g. you will notice inline math you messed up by accident due to the highlighted changes.

During the translation of the text from one language to another you should also consider to review a third translation as well since translations are usually not literal. Try to stay close to the German and English version although this may not always be possible.

Please also add your name(s) at the end of the `AUTHORS` file. 

#### Structure of the galleries

SURFER has to know certain details about the structure of the galleries in order to display them in the program. This structure is stored in the output filename (e.g. `fantasy_en.pdf` contains the name of the gallery and its language) and within the hierarchical bookmarks of the pdf file, e.g. for the English `fantasy` gallery it looks like this (indented lines are nested items):
```
Fantasy Surfaces
    fantasy_kolibri
Zitrus
    fantasy_zitrus
Tick
    fantasy_zeck
Hummingbird
    fantasy_kolibri
Nozzle
    fantasy_tuelle
Helix
    fantasy_helix
Nepali
    fantasy_nepali
Heaven and Hell
    fantasy_himmel
Quaste
    fantasy_quaste
Ding Dong
    fantasy_dingdong
Vis à Vis
    fantasy_visavis
Sweet
    fantasy_suess
Dullo
    fantasy_dullo
```

The first level always contains the label for the respective gallery (very first line) respectively gallery item of this gallery (third line to the end). The names at the second level are used for two purposes:

 1. The file name of the surface description file to load when this gallery item is clicked. The file extension `.jsurf` is added automatically.
 2. The file name of the prerendered icon for the gallery (item). Again, the file extension `.png` is added automatically.

The bookmarks are created by means of two LaTeX environments.

##### The surferIntroPage environment

Syntax:
```
\begin{surferIntroPage}{Gallery label}{icon}{Page title}
Text of the gallery introduction page
\end{surferIntroPage}
```
This enviroment is used for the very first page in a gallery containing general information about the gallery. 

For `icon` use the name of a PNG file (omitting the file extension `.png`). Usually, you can just leave the icon untouched. It is better to use the same icon for all languages.

##### The surferPage environment

Syntax:
```
\begin{surferPage}[Gallery item label]{Page title}
Text of the gallery page
\end{surferPage}
```

This environment is used for all but the very first page in a gallery to describe the surface associated with this gallery page. 

The optional `Gallery item label` is displayed in the gallery overview and may be omitted if the page title should be used as a label. Keep in mind that the label (resp. page title if label is omitted) should be concise since there is not much space to display it in the program.

#### Adding new translations via GitHub

This is the recommended way of contributing in general. Sending endless emails is error prone and time consuming, but still possible. If you want to contribute via GitHub, here are some general rules:

1. Fork the project to your account
2. Create a new branch called `xxxxx-translation` where `xxxxx` is the human readable name of your language (e.g. `english` or `turkish`). 
3. Apply changes *only* to this branch. Changes to others brachnes *will not be merged* with the `master` branch.
4. Once you have something ready to show, make a pull request for your branch and wait for our reply. 

This is not the place to give an introduction to git, GitHub and its workflow. There are many tutorials in the web, but feel free to ask specific questions using our [issue tracker](https://github.com/IMAGINARY/SURFER-Galleries/issues).

### Improving existing translations

You found a typo? You think, a certain translation is wrong or ambigious? [Report the issue on GitHub](https://github.com/IMAGINARY/SURFER-Galleries/issues/new) or [contact us directly](http://http//www.imaginary.org/contact).

License
-------

The gallery files and its sources are released under the `TODO` license. For details see the `LICENSE` file. By contributing to this project you automatically accepts that your contributions will be released under the same license terms.

Authors
-------

See the `AUTHORS` file.
