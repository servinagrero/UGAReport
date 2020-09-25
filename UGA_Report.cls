\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UGA_Report}[UGA report template]

%%
\PassOptionsToPackage{
  DIV  = 10,    % TODO: Make configurable
  BCOR = 10mm,  % TODO: Make configurable
}{typearea}

%%
\LoadClass[oneside,
pagesize,
12pt,
cleardoublepage=empty,
numbers=noenddot,
titlepage,
toc=bibliography,
toc=listof,
toc=index]{scrartcl}

\RequirePackage{ifpdf}
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}

\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi

\ifxetexorluatex
  \RequirePackage{fontspec}
\else
  \RequirePackage[utf8]{inputenc}
\fi

%% For macros
\usepackage{xparse}
\usepackage{xifthen}

\RequirePackage{titling} % To access document metadata

%% Languages
%% To choose french over english change `defaultlanguage` to french and add the rest to `otherlanguages`.
\RequirePackage{polyglossia}
\setdefaultlanguage{english}
\setotherlanguages{french}

\RequirePackage{ragged2e} % For text justification
\renewcommand{\raggedpart}{\flushleft}

\RequirePackage{setspace} % For spacing
\onehalfspacing

%% Mathematics
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{dsfont}

%% Symbol notation
\RequirePackage[binary-units=true]{siunitx}
\sisetup{%
  detect-all           = true,
  detect-family        = true,
  detect-mode          = true,
  detect-shape         = true,
  detect-weight        = true,
  detect-inline-weight = math,
}

%% Geometry
\RequirePackage{geometry}
\geometry{%
    verbose,
    tmargin=35mm,
    bmargin=30mm,
    lmargin=25mm,
    rmargin=25mm
}

%% Colors
\RequirePackage[table,xcdraw]{xcolor}

\definecolor{ugablue}{RGB}{42,46,70}
\definecolor{ugaorange}{RGB}{232,78,15}
\definecolor{ugared}{RGB}{239,62,56}
\definecolor{ugagray}{RGB}{78,81,83}

\RequirePackage{soul} % To underline text
\setul{0.8cm}{3pt}
\setulcolor{ugaorange}

%% Images
\RequirePackage{graphicx}
\graphicspath{%
    {Figures/}
    {Images/}
    {./}
}

%% Hyperlinks
\RequirePackage[
hidelinks,
colorlinks=true,
allcolors=ugared,
linktoc=all,
pdfusetitle]{hyperref}

%% Lists and tables
\RequirePackage[%
olditem,  % Do not modify itemize environments by default
oldenum   % Do not modify enumerate environments by default
]{paralist}

\RequirePackage{array}
\renewcommand{\arraystretch}{1.25}

\RequirePackage{float} % Finer control on floatings

%% Bibliography
\usepackage[backend=biber,
natbib=true,
style=ieee,
defernumbers=false,
sortcites]{biblatex}

%% Headers and footers
\RequirePackage[headsepline,footsepline]{scrlayer-scrpage}
\pagestyle{scrheadings}

%% Typesetting
% TODO: Customize captions
\RequirePackage{etoolbox} % Bold fonts in tables

\renewcommand{\labelitemi}{\textcolor{ugaorange}{$\bullet$}}
\renewcommand{\labelitemii}{\textcolor{ugaorange}{$\circ$}}
\renewcommand{\labelitemiii}{\textcolor{ugaorange}{\textbullet}}
\renewcommand{\labelitemiv}{\textcolor{ugaorange}{$\diamond$}}

\setlength{\headheight}{6mm}
\setlength{\footskip}{35mm}
\setlength{\footheight}{25mm}

\setlength{\parindent}{0cm}  % No paragraph indentation

\setkomafont{pageheadfoot}{\upshape}
\addtokomafont{pagehead}{\sffamily}

%% Headline and footerline
\setkomafont{headsepline}{\color{ugagray}}
\KOMAoptions{headsepline=1pt:.75\textwidth}
\setkomafont{footsepline}{\color{ugagray}}
\KOMAoptions{footsepline=1pt:.75\textwidth}

%% Footer
\rofoot*{\pagemark}
\cfoot*{}
\lofoot*{Université Grenoble Alpes}

%% Header
\rohead{\today}
\chead{}
\lohead{\includegraphics[height=20mm]{small_logo.jpg}}

%% Sections typesetting
% \addtokomafont{sectioning}{\fontfamily{pcr}\selectfont}

\setkomafont{section}{\ttfamily\Large\bfseries\MakeUppercase}
\setkomafont{subsection}{\large\ttfamily\bfseries\MakeUppercase}
\setkomafont{subsubsection}{\large\ttfamily\bfseries\MakeUppercase}

\renewcommand*{\sectionformat}{%
  \fontsize{35}{35}\selectfont\thesection\autodot\enskip
}

\renewcommand*{\subsectionformat}{%
  \fontsize{25}{25}\selectfont\thesubsection\autodot\enskip
}

\renewcommand*{\subsubsectionformat}{%
  \fontsize{20}{20}\selectfont\thesubsubsection\autodot\enskip
}


%% New commands
\newcommand{\documentdata}[2]{
    \def\coursename{#1}
    \def\documenttitle{#2}
}

\newcommand{\printcontents}[1][]{%
    \newpage
    \null{}
    {
        \thispagestyle{empty}
        \newpage
        \tableofcontents  % Index of the document
        \ifthenelse{\equal{#1}{lists}}{
            \listoffigures          % Index of pictures
            \listoftables           % Index of tables
        }{}%
        \newpage
    }
}


\newcommand{\maintitle}[0]{
    \begin{titlepage}
        \begin{center}
            \includegraphics[width=.5\textwidth]{main_uga_logo.eps}\\
            \vspace*{4cm}
            \begin{Huge}
                \ul{\MakeUppercase{\documenttitle}}~\\[2cm]
            \end{Huge}
            {\Large\coursename}~\\[4cm]
            \rule{.5\textwidth}{.8pt}~\\[0.3cm]
            \begin{large}
                \textsc{\theauthor}
            \end{large}
        \end{center}
        \vfill
    \end{titlepage}
}

%% New environments
% Table header with filled background
\newcommand{\hcell}[1]{\cellcolor{ugablue}{\color{white}\textbf{#1}}}

% Columns types
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
