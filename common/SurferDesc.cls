\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{SurferDesc}[2012/06/26 Class for Surfer description files]
\newif\if@languageDE
\newif\if@languageEN
\newif\if@languageRU
\newif\if@languageSR
\newif\if@languageES
\newif\if@languageNO
\DeclareOption{de}{\@languageDEtrue}
\DeclareOption{en}{\@languageENtrue}
\DeclareOption{ru}{\@languageRUtrue}
\DeclareOption{sr}{\@languageSRtrue}
\DeclareOption{es}{\@languageEStrue}
\DeclareOption{no}{\@languageNOtrue}
\DeclareOption*{%
\PackageWarning{SurferDesc}{Unknown option `\CurrentOption'}%
}
\ProcessOptions\relax
\LoadClass{amsart}

\newcommand{\changefont}[3]{
\fontfamily{#1} \fontseries{#2} \fontshape{#3} \selectfont}
\if@languageDE % load packages for german language support
\RequirePackage[latin1]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[ngerman]{babel}
\RequirePackage{ngerman}
\newcommand{\surferbffont}{\changefont{phv}{b}{n}}
\else
\if@languageRU % load packages for russian language support
\RequirePackage[utf8x]{inputenc}
\RequirePackage[russian]{babel}
\RequirePackage[T2A,T1]{autofe}
\newcommand{\surferbffont}{\bf}
\else
\if@languageSR % load packages for serbian language support
\RequirePackage[utf8x]{inputenc}
\RequirePackage[serbian]{babel}
\RequirePackage[T2A,T1]{autofe}
\newcommand{\surferbffont}{\bf}
\else
\if@languageES % load packages for spanish language support
\RequirePackage[utf8x]{inputenc}
\RequirePackage[spanish]{babel}
\RequirePackage[T2A,T1]{autofe}
\newcommand{\surferbffont}{\bf}
\else
\if@languageNO % load packages for norwegian language support
\RequirePackage[utf8x]{inputenc}
\RequirePackage[norsk]{babel}
\RequirePackage[T1]{autofe}
\newcommand{\surferbffont}{\bf}
\else
%\if@languageEN % load packages for english language support (default)
\RequirePackage[latin1]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[english]{babel}
\newcommand{\surferbffont}{\changefont{phv}{b}{n}}
%\fi
\fi
\fi
\fi
\fi
\fi


%
% Die folgenden Zeilen setzen Höhe und Breite der Gallerie-Einleitungen fest:
%
\newlength{\galIntroHeight}
\newlength{\galIntroWidth}
\setlength{\galIntroHeight}{11.61cm}
\setlength{\galIntroWidth}{10cm}

%
% Die folgenden Zeilen setzen Höhe und Breite des Erklärungs-Textes fest:
%
\newlength{\explHeight}
\newlength{\explWidth}
\setlength{\explHeight}{11.5cm}
\setlength{\explWidth}{7.46cm}

%
% Die folgenden Zeilen setzen einen (leeren, d.h.\ weißen) 
% Rahmen von 0.1 cm um den Text:
%
\RequirePackage[showframe]{geometry}

%
% some latex packages we might need:
%
\RequirePackage{showidx}
\RequirePackage{latexsym}
\RequirePackage{amsbsy,amscd,amsmath,amstext,amsthm}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{color}
\RequirePackage{dsfont}
\RequirePackage{varioref}
\RequirePackage{epsfig}
\RequirePackage{eso-pic}
\RequirePackage{graphicx}
\RequirePackage[active]{srcltx}
\RequirePackage{hyperref}
\RequirePackage{ifthen}
%\RequirePackage{pdftex}
\pdfimageresolution=72
%\pdfminorversion=4

\RequirePackage[scaled=0.92]{helvet}
\RequirePackage{multicol}
\RequirePackage{pstricks,pst-grad}
\RequirePackage{rotating}
\RequirePackage{setspace}
\onehalfspacing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Layout related stuff
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% for no indenting for a new paragraph:
%
\setlength{\parindent}{0pt} 
\setlength{\parskip}{1ex plus 0.5ex minus 0.2ex}

%
% don't use any roman fonts:
%
\def\rmdefault{cmss}        % no roman
\def\sfdefault{cmss}
\def\ttdefault{cmtt}
\def\itdefault{sl}
\def\sldefault{sl}
\def\bfdefault{bx}

\RequirePackage{sfmath} % use sans serif fonts in math mode


%
% some colors we'll use further down
%
\newrgbcolor{lightgrey}{.8 .8 .8}
\newrgbcolor{lightocher}{0.9 0.9 0.7}
\newrgbcolor{ocher}{0.7 0.7 0.5}
%\newrgbcolor{lightgrey}{.8 .8 .8}
%\newrgbcolor{lightocher}{0.9 0.9 0.65}
%\newrgbcolor{ocher}{0.7 0.7 0.35}
%\newrgbcolor{lightgrey}{.8 .8 .8}
%\newrgbcolor{lightocher}{0.8 0.8 0.8}
%\newrgbcolor{ocher}{0.7 0.7 0.7}

%
%
%
\definecolor{titleHgColor}{rgb}{0.0,0.0,0.0}
\definecolor{titleFgColor}{rgb}{0.9,0.9,0.7}
\definecolor{titleFgColorSnd}{rgb}{1.0,1.0,0.8}

\definecolor{picsHgColor}{rgb}{0.0,0.0,0.0}
\definecolor{picsFgColor}{rgb}{0.9,0.9,0.7}
\definecolor{picsFgColorSnd}{rgb}{0.95,0.95,0.75}

% white bg:
\definecolor{textHgColor}{rgb}{1.0,1.0,1.0}
% light ocker bg:
%\definecolor{textHgColor}{rgb}{0.69,0.62,0.41}
\definecolor{textFgColor}{rgb}{0.15,0.15,0.1}
\definecolor{textFgColorSnd}{rgb}{0.4,0.4,0.2}
\definecolor{textFgColorDark}{rgb}{0.1,0.1,0.07}

%
% some commands we often use:
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%The black board font
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\newcommand{\bK}{{\bf K}}
\newcommand{\bK}{{\Bbbk}}
%\newcommand{\bK}{{\mathbb k}}
\newcommand{\AAA}{{\mathbb A}}
\newcommand{\BB}{{\mathbb B}}
\newcommand{\CC}{{\mathbb C}}
\newcommand{\DD}{{\mathbb D}}
\newcommand{\EE}{{\mathbb E}}
\newcommand{\FF}{{\mathbb F}}
\newcommand{\GG}{{\mathbb G}}
%\newcommand{\HH}{{\mathbb H}}
\newcommand{\II}{{\mathbb I}}
\newcommand{\JJ}{{\mathbb J}}
\newcommand{\KK}{{\mathbb K}}
%\newcommand{\LL}{{\mathbb L}}
\newcommand{\MM}{{\mathbb M}}
\newcommand{\NN}{{\mathbb N}}
%\newcommand{{\mathbb O}}
\newcommand{\PP}{{\mathbb P}}
\newcommand{\QQ}{{\mathbb Q}}
\newcommand{\RR}{{\mathbb R}}
\newcommand{\SSS}{{\mathbb S}}
\newcommand{\TT}{{\mathbb T}}
\newcommand{\UU}{{\mathbb U}}
\newcommand{\VV}{{\mathbb V}}
\newcommand{\WW}{{\mathbb W}}
\newcommand{\XX}{{\mathbb X}}
\newcommand{\YY}{{\mathbb Y}}
\newcommand{\ZZ}{{\mathbb Z}}


\newcommand{\dontshow}[1]{}

\newcommand{\smcdot}{{\textup{$\cdot$}}}

\newcommand{\UnderscoreCommands}{\do\pdfbookmark}
\RequirePackage[strings]{underscore}

\RequirePackage[force]{filehook}
\RequirePackage{currfile}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Begin: surfer stuff
% (Some environments for the text pages for the surfer software)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{etoolbox}


\newenvironment{surferIntroPage}[1]{% 
  % the page background color:
  \pagecolor{textHgColor}%
  % the page font color:
  \color{textFgColor}%
  % no page headers or footers:
  \thispagestyle{empty}%
  % resize font
  \footnotesize\par%
  %%%%% 
  \begin{flushleft}%
  {\pdfbookmark{\currfilebase}{\currfilebase}\surferbffont #1}\par}%
{\end{flushleft}}

\newenvironment{surferPage}[1]{% 
  % the page background color:
  \pagecolor{textHgColor}%
  % the page font color:
  \color{textFgColor}%
  % no page headers or footers:
  \thispagestyle{empty}%
  % resize font
  \footnotesize\par%
  %%%%% 
  \begin{flushleft}%
  {\pdfbookmark{\currfilebase}{\currfilebase}\surferbffont #1}\par}%
{\end{flushleft}}


% adjust page geometry for 'surferIntroPage' environment (page layout changes must not be encapsulated in the group of 'surferIntroPage')
\BeforeBeginEnvironment{surferIntroPage}{%
  \clearpage%
  \eject%
  \global\pdfpagewidth=\galIntroWidth \global\pdfpageheight=\galIntroHeight%
  \newgeometry{layoutsize={\galIntroWidth,\galIntroHeight},left=0.1cm,right=0.1cm,bottom=0.1cm,top=0.05cm,showframe=true}%  
}

% adjust page geometry for 'surferPage' environment (page layout changes must not be encapsulated in the group of 'surferPage')
\BeforeBeginEnvironment{surferPage}{%
  \clearpage%
  \eject%
  \global\pdfpagewidth=\explWidth \global\pdfpageheight=\explHeight%
  \newgeometry{layoutsize={\explWidth,\explHeight},left=0.1cm,right=0.1cm,bottom=0.1cm,top=0.05cm,showframe=true}%  
}
