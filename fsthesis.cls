%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% This file is: 'fsthesis.cls'
%%
%% Written by: Graeme Nott, Apr 2020
%%
%% This class has been written as a add-on to the class 'book.cls'.
%% book.cls is called by this file and certain features modified.
%% There is an (commented) option that uses the fontspec package to load
%% TrueType fonts, if used the document must be compiled with XeLaTeX
%% (untested) or LuaLaTeX. Otherwise use pdfLaTeX.
%%
%% Modified items:
%%  margins and interline spacing (York requirements)
%%  default fonts to ...
%%  title page defined
%%  Bibliography renamed References
%%  headers/footers redefined
%%  font and spacing of float captions
%%  section/subsection/subsubsection font
%%  chapter headings
%%  spacing of footnotes
%%  define reaction environment based on equation with different numbering
%
% HISTORY
%
% (2020) Class file created based on GN's thesis class. Brought up to date but
%        is still some TeX. Mainly used for chapter heading formatting. Specs
%        for University of York thesis added.
%        www.york.ac.uk/research/graduate-school/academic/thesis/format/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% ==IDENTIFICATION===========================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fsthesis}[v0.1 Freya Squires' University of York Thesis Class]

%% ==DEFINE OPTIONS===========================================================

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
%- All user-defined options are passed to book.cls

\ProcessOptions\relax

%% ==LOAD PREREQUISITES=======================================================
\LoadClass[12pt,a4paper]{book}
\RequirePackage{ifthen,calc}
\RequirePackage{fancyhdr}
\PassOptionsToPackage{hyphens}{url}
\RequirePackage[pdftex,%
                hidelinks=true,%
                pagebackref=true,%
                linktoc=all]{hyperref}

%% ==MAIN CODE================================================================

%% -- Define fonts -----------------------------------------------------------
%% Use combination of Alegreya and AlegreyaSans
%%
%% This will fall over if these fonts are not installed.
%% Need to include a \IfFontExistsTF{...
%% dl from https://fontpair.co/downloads/Alegreya%20Sans%20and%20Alegreya.zip
%% ---------------------------------------------------------------------------

% Fall-back fonts when not using fontspec
%\RequirePackage{fontspec}
\RequirePackage[T1]{fontenc}
\RequirePackage{helvet,mathptmx}

%\setmainfont{Alegreya}[
%    Ligatures=TeX,
%    UprightFont = *-Regular,
%    ItalicFont = *-Italic,
%%    SmallCapsFont = AlegreyaSC-Regular.otf, % Can't get this to work
%    BoldFont = *-Bold,
%    BoldItalicFont = *-BoldItalic
%]
%
%\setsansfont{AlegreyaSans}[
%    Ligatures=TeX,
%    UprightFont = *-Regular,
%    ItalicFont = *-Italic,
%    BoldFont = *-Bold,
%    BoldItalicFont = *-BoldItalic
%]

%% -- Define page margins etc ------------------------------------------------
%% University of York requirements are:
%% * inner margin >= 40mm
%% * all other margins >= 15mm
%% * Headers and footers/page numbers should be within the recommended margins
%%   at the top and bottom of the page and preferably no nearer the edge of
%%   the paper than half the margin width.
%% ---------------------------------------------------------------------------
\usepackage[inner=40mm,
            includeheadfoot=false,
            headheight=10mm,
            footskip=20mm+1ex]{geometry}

%adjust line spacing
\renewcommand{\baselinestretch}{1.25}

%%% TODO: Sort out header and footer lengths
\raggedbottom

%% --Define some marco shortcuts----------------------------------------------

\newcommand{\etal}{~\textit{et\,al.}}

%% --Redefine mainmatter so that page numbering is not reset-----------
\makeatletter
\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  %\pagenumbering{roman}% Don't reset
}
\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  %\pagenumbering{arabic}% Don't reset
}
\makeatother
%\makeatletter
%\def\pagenumbering#1{%
 % \gdef\thepage{\csname @#1\endcsname \c@page}}
%\makeatother

%% -- Define Title Page ------------------------------------------------------
%% The title page of every volume shall give the following information in the
%% order listed, and on separate lines:
%% * The full title of the thesis and any subtitle (\title).
%% * The total number of volumes (\totalvol), if more than one, and the number
%%   of the particular volume (\docvol).
%% * The full name of the author (\author) followed, if desired, by any
%%   qualifications and distinctions.
%% * The qualification for which the thesis is submitted (\degree), if not
%%   given then PhD is assumed.
%% * The name of the University (\university), if not given then University
%%   of York is assumed.
%% * The name of the Department or Centre in which the research was conducted
%%   (\dept), if not given then WACL is assumed.
%% * The month and year the thesis of submission (\date).
%%
%% The titlepage is counted as the first page but no page number is shown.
%% ---------------------------------------------------------------------------

% Define titlepage variables
% Document volume, shown if thesis consists of more than one volume
\newcommand*{\docvol}[1]{\gdef\@docvol{#1}}
\newcommand*{\@docvol}{\textit{n}}
% Total number of volumes in thesis
\newcommand*{\totalvol}[1]{\gdef\@totalvol{#1}}
\newcommand*{\@totalvol}{\textit{x}}
% Type of degree. If not given then default is 'PhD'
\newcommand*{\degree}[1]{\gdef\@degree{#1}}
\newcommand*{\@degree}{undefined}
% University. If not given default is 'University of York'
\newcommand*{\university}[1]{\gdef\@university{#1}}
\newcommand*{\@university}{undefined}
% University department/centre. If not given default is 'Chemistry'.
\newcommand*{\dept}[1]{\gdef\@dept{#1}}
\newcommand*{\@dept}{undefined}
% Redefine date format to month and year. Note that this will affect the entire document.
% from https://tex.stackexchange.com/questions/112932/today-month-as-text#112935
\renewcommand{\today}{%
\ifcase \month \or January\or February\or March\or April\or May%
\or June\or July\or August\or September\or October\or November\or December\fi%
\space\number\year}


%% -- Create the document titlepage ------------------------------------------
\renewcommand*{\maketitle}{%
\begin{titlepage}
\sffamily
\bfseries
\begin{center}
\vspace*{3cm}
{\bfseries\fontsize{25pt}{25pt}\selectfont\@title\unskip\strut\par}
\vspace{2cm}
{\bfseries\fontsize{25pt}{25pt}\selectfont\@author\unskip\strut\par}
\vspace{4cm minus 2cm}
\ifthenelse{%
    \equal{\@degree}{undefined}}%
    {\Large{PhD\\}}%
    {\large\@degree\\}
\vspace{2cm}
\ifthenelse{%
    \equal{\@university}{undefined}}%
    {\Large{University of York\\}}%
    {\Large\@university\\}
\vspace{1cm}
\ifthenelse{%
    \equal{\@dept}{undefined}}%
    {\Large{Chemistry\\}}%
    {\Large\@dept\\}
\vspace{1cm}
\@date\unskip\\
\vfill
\end{center}
\end{titlepage}
\thispagestyle{empty}

\pagebreak
}


%% -- Rename bibliography to References ---------------------------------------
\renewcommand{\bibname}{References}


%% -- Add some `pretty` formatting to the backreferences in References --------
%% from https://tex.stackexchange.com/questions/183702/formatting-back-references-in-bibliography-bibtex
\renewcommand*{\backref}[1]{}
\renewcommand*{\backrefalt}[4]{%
    \ifcase #1%
          \or [Page~#2.]%
          \else [Pages~#2.]%
    \fi%
    }

%similar for glossaries is here
%https://tex.stackexchange.com/questions/256152/glossaries-modified-page-list-back-references
% \renewcommand*{\glsnumberformat}[1]{ [Page~#1.]}


%% -- Remove dotted lines from table of contents -----------------------------

%% NOTE: This breaks the class file!!

%\makeatletter
%\addtocontents{toc}{\def\string\@dotsep{200}}
%\makeatother


%% -- Use Fancyheadings to create headers/footers ----------------------------
\pagestyle{fancy}
%\addtolength{\headwidth}{\marginparsep}
%\addtolength{\headwidth}{\marginparwidth}
%\renewcommand{\chaptermark}[1]{\markboth{\thechapter:\ #1}{}}

\renewcommand{\chaptermark}[1]{%
%    \markboth{\chaptername\ \thechapter.\ #1}{}
    \markboth{#1}{}
}

\renewcommand{\sectionmark}[1]{%
    \markright{\thesection:\ #1}{}
}

\fancyhf{}
\fancyhead[RO]{\nouppercase{\rightmark}}
\fancyhead[LE]{\nouppercase{\leftmark}}
%\fancyhead[LE]{\textbf{\rightmark}}
%\fancyhead[RO]{\textbf{\leftmark}}
\fancyfoot[RO]{\thepage}
\fancyfoot[LE]{\thepage}

% Redefine the plain pagestyle to have same style page numbering
\fancypagestyle{plain}{%
    % No headers, only page numbers
    \fancyhead{} % get rid of headers
    \fancyfoot[RO]{\thepage}
    \fancyfoot[LE]{\thepage}
    \renewcommand{\headrulewidth}{0pt} % and the line
}

% Redefinition of \cleardoublepage so that is fancyhdr style empty
% Note that the recipe in the fancyhdr docs breaks this class
\let\oldcleardoublepage = \cleardoublepage
\renewcommand{\cleardoublepage}{
  \thispagestyle{plain}
  \oldcleardoublepage
}

%% --Float captions-----------------------------------------------------------
% Makes caption text single spaced
%% Note that this redefines the makecaption command, if packages such as
% caption are used then this will be overwritten

%\setlength\abovecaptionskip{0\p@}%	was 10
%\setlength\belowcaptionskip{5\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \renewcommand{\baselinestretch}{1}\selectfont
  \sbox\@tempboxa{#1: #2}%
%  \sbox\@tempboxa{\small{{\sffamily\textbf{#1 }} #2}}%
  \ifdim \wd\@tempboxa >\hsize
    #1: #2\par%
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

%% --Section headings---------------------------------------------------------
%- Makes headings all bold serif of different sizes

\renewcommand\section{\@startsection{section}{1}{\z@}%
                      {-3.5ex \@plus -1ex \@minus -.2ex}%
                      {2.3ex \@plus.2ex}%
                      {\raggedright\Large\bfseries}}%
                    % {\raggedright\sffamily\Large\bfseries}}%
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                         {-3.25ex\@plus -1ex \@minus -.2ex}%
                         {1.5ex \@plus .2ex}%
                         {\raggedright\large\bfseries}}%
                        % {\raggedright\sffamily\large\bfseries}}%
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                            {-3.25ex\@plus -1ex \@minus -.2ex}%
                            {1.5ex \@plus .2ex}%
                            {\raggedright\rmfamily\normalsize\bfseries}}%
                           % {\raggedright\sffamily\normalsize\bfseries}}%

%% --Chapter headings---------------------------------------------------------
%- Makes chapter titles big, bold, and serif. Chapter number is
%- very big on outer edge. Starred version has no number.
% Note: \m@ne = -1, \p@ = pt

\newlength{\chapboxlength}
\setlength{\chapboxlength}{\textwidth*\real{0.75}}
\newlength{\chaptitlelength}

\def\@makechapterhead#1{%
  \settowidth{\chaptitlelength}{\bfseries\fontsize{30pt}{30pt}\selectfont#1}
%  \settowidth{\chaptitlelength}{\sffamily\bfseries\fontsize{30pt}{30pt}\selectfont#1}
  \vspace*{50\p@}%
  \noindent%
%This is a primitive way of trying to force title into 2 lines
  \ifdim \chaptitlelength > \chapboxlength
    \parbox[b]{\chapboxlength}{%
      \renewcommand{\baselinestretch}{1.25}%
      \raggedright\bfseries\fontsize{30pt}{30pt}\selectfont#1}
%      \raggedright\sffamily\bfseries\fontsize{30pt}{30pt}\selectfont#1}
  \else
    \parbox[b]{\textwidth*\real{0.75}}{%    %% This was \textwidth*0.5
      \renewcommand{\baselinestretch}{1.25}%
      \raggedright\bfseries\fontsize{30pt}{30pt}\selectfont#1}
%      \raggedright\sffamily\bfseries\fontsize{30pt}{30pt}\selectfont#1}
  \fi
  \hfill
  \begin{minipage}[b]{50pt}%
    \raggedleft\bfseries\fontsize{85pt}{85pt}\selectfont\thechapter
%    \raggedleft\sffamily\bfseries\fontsize{85pt}{85pt}\selectfont\thechapter
  \end{minipage}%
  \vskip 50\p@ plus\baselineskip minus\baselineskip%
 }

\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \renewcommand{\baselinestretch}{1.25}%
    \bfseries\fontsize{30pt}{30pt}\selectfont#1\par\nobreak
%    \sffamily\bfseries\fontsize{30pt}{30pt}\selectfont#1\par\nobreak
    \vskip 50\p@
  }}


%% --Change footnote spacing-------------------------------------------
%- Makes footnotes single spacing

\renewcommand\@makefntext[1]{%
    \renewcommand{\baselinestretch}{1}\selectfont
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}


%% --Chemical Reaction (equation) Environment--------------------------
%% from https://latex.org/forum/viewtopic.php?t=10299
\newcounter{react}
\newenvironment{reaction}
   {\stepcounter{react}%
     \addtocounter{equation}{-1}%
     \renewcommand\theequation{R\arabic{react}}\equation}
   {\endequation}


\endinput
%% ==EOF===============================================================
