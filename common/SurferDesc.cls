\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{SurferDesc}[2016/04/18 Class for Surfer description files]
\def\SurferDesc@version{0.16.0}

\RequirePackage{xkeyval}

\newif\if@SurferDesc@LatinCyrillic\@SurferDesc@LatinCyrillicfalse
\global\newif\if@SurferDesc@CJK\@SurferDesc@CJKfalse
\newif\if@SurferDesc@HebrewArabic\@SurferDesc@HebrewArabicfalse

\define@choicekey*+{SurferDesc.cls}{mainlanguage}[\val\nr]{arabic,chinese,traditional-chinese,croatian,dutch,english,french,german,hebrew,korean,norwegian,portuges,russian,serbian,spanish,turkish}[english]{%
    \global\edef\SurferDesc@mainlanguage{\val}
    \ifcase\nr
        % arabic
        \global\@SurferDesc@HebrewArabictrue
    \or
        % chinese
        \global\@SurferDesc@CJKtrue
    \or
        % traditional-chinese
        \global\@SurferDesc@CJKtrue
    \or
        % croatian
        \global\@SurferDesc@LatinCyrillictrue
    \or
    	% dutch
        \global\@SurferDesc@LatinCyrillictrue
    \or
    	% english
        \global\@SurferDesc@LatinCyrillictrue
    \or
    	% french
        \global\@SurferDesc@LatinCyrillictrue
    \or
    	% german
        \global\@SurferDesc@LatinCyrillictrue
    \or
    	% hebrew
        \global\@SurferDesc@HebrewArabictrue
    \or
    	% korean
        \global\@SurferDesc@CJKtrue
    \or
    	% norwegian
        \global\@SurferDesc@LatinCyrillictrue
        \global\edef\SurferDesc@mainlanguage{norsk}
    \or
    	% portuguese
        \global\@SurferDesc@LatinCyrillictrue
    \or
    	% russian
        \global\@SurferDesc@LatinCyrillictrue
    \or
    	% serbian
        \global\@SurferDesc@LatinCyrillictrue
    \or
    	% spanish
        \global\@SurferDesc@LatinCyrillictrue
    \or
        % turkish
        \global\@SurferDesc@LatinCyrillictrue
    \fi
}{%
    \ClassError{SurferDesc.cls}{Erroneuos value '\val' for option key 'mainlanguage'}{Set 'mainlanguage' to either arabic, chinese, dutch, english, french, german, hebrew, korean, norwegian, portuges, russian, serbian, spanish or turkish}
}
\DeclareOptionX*{\ClassWarning{SurferDesc}{Unknown option '\CurrentOption'}}
\ProcessOptionsX<SurferDesc.cls>

% ensure default value of mainlanguage is set to english
\ifdefined\SurferDesc@mainlanguage
\else
    \global\edef\SurferDesc@mainlanguage{english}
    \global\@SurferDesc@LatinCyrillictrue
\fi

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
\if@SurferDesc@CJK
    % support for Chinese-Japanese-Korean script
    \usepackage[space]{xeCJK}
    \IfFileExists{wqy-zenhei.ttc}%
      {\setCJKsansfont[Ligatures=TeX,AutoFakeBold=3.25,AutoFakeSlant]{wqy-zenhei.ttc}}
      {\setCJKsansfont[Ligatures=TeX,AutoFakeBold=3.25,AutoFakeSlant]{WenQuanYi Zen Hei}}
\else
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
    \if@SurferDesc@HebrewArabic
        % load DejaVu Sans for hebrew and arabic
        \newfontfamily\hebrewfont[Script=Hebrew]{DejaVu Sans}
        \newfontfamily\arabicfont[Script=Arabic, AutoFakeSlant]{DejaVu Sans Condensed}
    \fi

    % hyphenation support
    \RequirePackage{polyglossia}
\fi

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

\hypersetup{pdfcreator={LaTeX2e with package SurferDesc (version \SurferDesc@version)}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Language selection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\if@SurferDesc@CJK
    \relax
\else
    \ifx\SurferDesc@mainlanguage english
        \setmainlanguage{english}
    \else
        \expandafter\setmainlanguage\expandafter{\SurferDesc@mainlanguage}
        \setotherlanguage{english}
    \fi
\fi

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

% writing direction aware flush environment
\newenvironment{SurferDescFlush}{\begin{flushleft}}{\end{flushleft}}
\if@SurferDesc@HebrewArabic
    \renewenvironment{SurferDescFlush}{\begin{flushright}}{\end{flushright}}
\fi

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
    \currentpdfbookmark{#1}{\currfilebase}
    \belowpdfbookmark{#2}{\currfilebase.fileprefix}
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
    \currentpdfbookmark{\IfValueTF{#1}{#1}{\surferPage@title}}{\currfilebase}
    \belowpdfbookmark{\currfilebase}{\currfilebase.fileprefix}
    \bfseries\boldmath #2
  }\par%
  }%
{\end{SurferDescFlush}}

% scale up each page (required since LGPL JPedal PDF renderer only renders at 72dpi)
\usepackage{blowup}
\def\SurferDesc@pageScaleFactor{3}
\blowUp{paper=x\SurferDesc@pageScaleFactor}

% fix page scaling when bidi package is loaded by polyglossia
\newcommand{\@SurferDesc@restore@rtl@mode}{\if@RTL\gdef\restore@rtl@mode{\setRL}\else\gdef\restore@rtl@mode{}\fi}%
\if@SurferDesc@HebrewArabic{%
    \@ifpackageloaded{bidi}{
        \global\let\old@BL@scalePage\BL@scalePage
        \gdef\BL@scalePage{%
            \@SurferDesc@restore@rtl@mode%
            \setLR%
            \old@BL@scalePage%
            \restore@rtl@mode%
        }
    }{}%
}\fi

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
