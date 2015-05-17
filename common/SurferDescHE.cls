\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{SurferDesc}[2014/03/13 Class for Surfer description files]
\DeclareOption*{\PackageWarning{SurferDesc}{Unknown option `\CurrentOption'}}
\ProcessOptions\relax

% base this documentcalss on AMS article
\LoadClass[8pt]{amsart}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonts, symbols, hyphenation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% enhanced math typesetting and symbols
\RequirePackage{amsmath,amsfonts,amssymb}
\newcommand{\RR}{{\mathbb R}}

% sans serif fonts in math mode
\RequirePackage{sfmath}

% load Computer Modern Unicode Sans Serif fonts
\RequirePackage[no-math]{fontspec} 
\defaultfontfeatures{Mapping=tex-text}
\setmainfont[
  Ligatures=TeX,
  Extension=.otf,
  SlantedFont=cmunsi,
  BoldFont=cmunsx,
  ItalicFont=cmunsi,
  BoldItalicFont=cmunso
]{cmunss}

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
\RequirePackage[bookmarksopen=true]{hyperref}
\RequirePackage{csquotes}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Environments for the SURFER gallery pages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% provides macros containing the current file name (of included files)
\RequirePackage[force]{filehook}
\RequirePackage{currfile}

% patch some macros to allow underscores as part of arguments
\newcommand{\UnderscoreCommands}{\do\currentpdfbookmark \do\belowpdfbookmark}
\RequirePackage[strings]{underscore}

% enhanced declaration of new commands and environment
\RequirePackage{xparse}

% patch commands and enviroments
\RequirePackage{etoolbox}

% colors for fore- and background
\definecolor{textHgColor}{rgb}{1.0,1.0,1.0}
\definecolor{textFgColor}{rgb}{0.15,0.15,0.1}


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
  \begin{flushright}%
  {%
    \currentpdfbookmark{#1}{\currfilebase}
    \belowpdfbookmark{#2}{\currfilebase.fileprefix}
    \bfseries\boldmath #3
  }\par%
  }%
{\end{flushright}}

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
  \begin{flushright}%
  {%
    \currentpdfbookmark{\IfValueTF{#1}{#1}{\surferPage@title}}{\currfilebase}
    \belowpdfbookmark{\currfilebase}{\currfilebase.fileprefix}
    \bfseries\boldmath #2
  }\par%
  }%
{\end{flushright}}

% scale up each page (required since LGPL JPedal PDF renderer only renders at 72dpi)
\usepackage{blowup}
\def\SurferDesc@pageScaleFactor{3}
\blowUp{paper=x\SurferDesc@pageScaleFactor}

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
