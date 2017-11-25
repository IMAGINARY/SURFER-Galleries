\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{SurferDesc}[2017/11/25 Class for Surfer description files]
\def\SurferDesc@version{0.18.0}

% base this documentclass on AMS article
\LoadClass[8pt]{amsart}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonts, symbols, hyphenation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% enhanced math typesetting and symbols
\RequirePackage{amsmath,amsfonts,amssymb}
\newcommand{\RR}{{\mathbb R}}

% sans serif fonts in math mode
\RequirePackage{sfmath}

\RequirePackage[no-math]{fontspec}

% support for Chinese-Japanese-Korean script
\usepackage[space]{xeCJK}
\IfFileExists{wqy-zenhei.ttc}%
  {\setCJKsansfont[Ligatures=TeX,AutoFakeBold=3.25,AutoFakeSlant]{wqy-zenhei.ttc}}
  {\setCJKsansfont[Ligatures=TeX,AutoFakeBold=3.25,AutoFakeSlant]{WenQuanYi Zen Hei}}

% load Computer Modern Unicode Sans Serif fonts
\defaultfontfeatures{Mapping=tex-text}
\setmainfont[
  Ligatures=TeX,
  Extension=.otf,
  SlantedFont=cmunsi,
  BoldFont=cmunsx,
  ItalicFont=cmunsi,
  BoldItalicFont=cmunso
]{cmunss}

% load DejaVu Sans for hebrew and arabic
\newfontfamily\hebrewfont[Script=Hebrew]{DejaVu Sans}
\newfontfamily\arabicfont[Script=Arabic, AutoFakeSlant]{DejaVu Sans Condensed}

% hyphenation support
\RequirePackage{polyglossia}

% subliminal refinements towards typographical perfection
\RequirePackage{microtype}

% default font family: sans serif instead of roman
\renewcommand*{\familydefault}{\sfdefault}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Layout related stuff
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% required to set page geometry for each page
\RequirePackage{geometry}

% size of gallery introduction pages
\newlength{\galIntroHeight}
\newlength{\galIntroWidth}
\setlength{\galIntroHeight}{12cm}
\setlength{\galIntroWidth}{10.34cm}

% size of regular gallery page
\newlength{\explHeight}
\newlength{\explWidth}
\setlength{\explHeight}{11.5cm}
\setlength{\explWidth}{7.46cm}

% use line spacing of one and a half
\RequirePackage{setspace}
\onehalfspacing

% do not indent paragraphs
\setlength{\parindent}{0pt}
\setlength{\parskip}{1ex plus 0.5ex minus 0.2ex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Additional packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage[open]{bookmark}
\RequirePackage{csquotes}
\DeclareQuoteStyle{romanian}% verified
  {\quotedblbase}
  {\textquotedblright}
  {\guillemotleft}
  {\guillemotright}

\hypersetup{pdfcreator={LaTeX2e with package SurferDesc (version \SurferDesc@version)}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Language selection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setmainlanguage{english}
\setotherlanguages{arabic,dutch,english,french,german,hebrew,italian,norwegian,portuges,romanian,russian,serbian,spanish,turkish}

\RequirePackage{ifthen}

\newcommand{\setgallerylanguage}[2]{%
    \clearpage%
    \global\def\@SurferDesc@language{#1}%
    \global\def\@SurferDesc@languagecode{#2}%
    \makexeCJKinactive
    \ifthenelse{\equal{#1}{korean}\or\equal{#1}{chinese}\or\equal{#1}{traditional-chinese}}{%
        \selectlanguage{english}%
        \makexeCJKactive
    }{%
        % workaround for polyglossia bug with 'german' language
        \ifthenelse{\equal{#1}{german}}{\selectlanguage{ngerman}}{\selectlanguage{#1}}%
    }%
    \bookmark[level=0,page=\thepage]{#2}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Importing galleries
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\usepackage{import}

\newcommand{\includegallery}[1]{%
    \clearpage%
    \bookmark[level=1,page=\thepage]{#1}%
    \subimport{#1/\@SurferDesc@languagecode/}{#1\string_\@SurferDesc@languagecode}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Environments for the SURFER gallery pages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% provides macros containing the current file name (of included files)
\RequirePackage[force]{filehook}
\RequirePackage{currfile}

% patch some macros to allow underscores as part of arguments
\newcommand{\UnderscoreCommands}{\do\subimport}
\RequirePackage[strings]{underscore}

% enhanced declaration of new commands and environment
\RequirePackage{xparse}

% patch commands and enviroments
\RequirePackage{etoolbox}

% colors for fore- and background
\definecolor{textHgColor}{rgb}{1.0,1.0,1.0}
\definecolor{textFgColor}{rgb}{0.15,0.15,0.1}

% writing direction aware flush environment
\newenvironment{SurferDescFlush}{%
    \ifthenelse{\equal{\@SurferDesc@language}{arabic}}{\begin{flushright}}{\ifthenelse{\equal{\@SurferDesc@language}{hebrew}}{\begin{flushright}}{\begin{flushleft}}}%
}{%
    \ifthenelse{\equal{\@SurferDesc@language}{arabic}}{\end{flushright}}{\ifthenelse{\equal{\@SurferDesc@language}{hebrew}}{\end{flushright}}{\end{flushleft}}}%
}

% introduction page for a gallery; arguments:
%  #1 title of the gallery (mandatory)
%  #2 base name of the jsurf/png file to be used as a gallery icon (mandatory)
%  #3 page title of the gallery introduction page (mandatory)
\DeclareDocumentEnvironment{surferIntroPage}{m m +m}{%
  % the page background color:
  \pagecolor{textHgColor}%
  % the page font color:
  \color{textFgColor}%
  % no page headers or footers:
  \thispagestyle{empty}%
  %%%%%
  \begin{SurferDescFlush}%
  {%
    \bookmark[level=2,page=\thepage]{#1}
    \bookmark[level=3,page=\thepage]{#2}
    \bfseries\boldmath #3
  }\par%
  }%
{\end{SurferDescFlush}}

% gallery page; arguments:
%  #1 icon label of this page (defaults to page title if not specified) (optional)
%  #2 page title of the gallery page (mandatory)
\DeclareDocumentEnvironment{surferPage}{o +m}{%
  \def\surferPage@title{#2}
  % the page background color:
  \pagecolor{textHgColor}%
  % the page font color:
  \color{textFgColor}%
  % no page headers or footers:
  \thispagestyle{empty}%
  %%%%%
  \begin{SurferDescFlush}%
  {%
    \bookmark[level=2,page=\thepage]{\IfValueTF{#1}{#1}{\surferPage@title}}
    \bookmark[level=3,page=\thepage]{\currfilebase}
    \bfseries\boldmath #2
  }\par%
  }%
{\end{SurferDescFlush}}

% scale up each page (required since LGPL JPedal PDF renderer only renders at 72dpi)
%\usepackage{blowup}
\def\SurferDesc@pageScaleFactor{1}
%\blowUp{paper=x\SurferDesc@pageScaleFactor}

% fix page scaling when bidi package is loaded by polyglossia
\newcommand{\@SurferDesc@restore@rtl@mode}{\if@RTL\gdef\restore@rtl@mode{\setRL}\else\gdef\restore@rtl@mode{}\fi}%
%\if@SurferDesc@HebrewArabic{%
    \@ifpackageloaded{bidi}{
        \global\let\old@BL@scalePage\BL@scalePage
        \gdef\BL@scalePage{%
            \@SurferDesc@restore@rtl@mode%
            \setLR%
            \old@BL@scalePage%
            \restore@rtl@mode%
        }
    }{}%
%}\fi

% adjust page geometry for 'surferIntroPage' environment (page layout changes must not be encapsulated in the group of 'surferIntroPage')
\BeforeBeginEnvironment{surferIntroPage}{%
  \clearpage%
  \eject%
  \global\pdfpagewidth=\SurferDesc@pageScaleFactor\galIntroWidth \global\pdfpageheight=\SurferDesc@pageScaleFactor\galIntroHeight%
  \newgeometry{layoutsize={\galIntroWidth,\galIntroHeight},left=0.1cm,right=0.1cm,bottom=0.1cm,top=0.05cm,showframe=true}%
}

% adjust page geometry for 'surferPage' environment (page layout changes must not be encapsulated in the group of 'surferPage')
\BeforeBeginEnvironment{surferPage}{%
  \clearpage%
  \eject%
  \global\pdfpagewidth=\SurferDesc@pageScaleFactor\explWidth \global\pdfpageheight=\SurferDesc@pageScaleFactor\explHeight%
  \newgeometry{layoutsize={\explWidth,\explHeight},left=0.1cm,right=0.1cm,bottom=0.1cm,top=0.05cm,showframe=true}%
}
