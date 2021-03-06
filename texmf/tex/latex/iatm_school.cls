% Base this on the article class.
\LoadClass[letterpaper,twoside,12pt]{article}

% Basic dependency stuff.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iatm_school}[2015/09/17 rst2latex class for notes and homework]

% Configure page layout.
\RequirePackage{geometry}
% Use letterpaper.
\geometry{letterpaper}
% Use 0.75in margins on the top and bottom.
% This uses more paper than rst2latex normally does (it has huge margins).
\geometry{vmargin=1in}
% Also, include headers and footers in this, because my printer otherwise cuts
% them off when printing double-sided.
\geometry{includeheadfoot}
% This is two-sided.
\geometry{twoside}
% Include a binding offset for 3-hole punch to put into a binder.
\geometry{bindingoffset=0.5in}
% Inner and outer margins.
\geometry{inner=0.5in,outer=0.75in}

% The header and footer (included by the Makefile) need color with usenames.
% rst2latex.py loads it without usenames when code is color-coded.
% Load it before that happens.
\RequirePackage[usenames]{color}

% Use the T1 font encoding
\RequirePackage[T1]{fontenc}

% Use DejaVu Sans Mono for code and such.
% Make sure it's shrunk a bit, so 80-char lines of code don't run too far past
% the margins.
\RequirePackage[scaled=0.8]{DejaVuSansMono}

% Use French spacing (no double spaces after a sentence).
\frenchspacing

% Space out paragraphs, don't indent.
\setlength{\parskip}{\baselineskip}
\setlength{\parindent}{0pt}

% Prettify the PDF output.
\RequirePackage{microtype}

% Format section headings.
\RequirePackage{titlesec}
\titleformat{\section}{\Large\bf\scshape\raggedright}{}{}{}[\titlerule]
\titleformat{\subsection}{\large\bf\scshape\raggedright}{}{}{}

% Headers and footers.
\RequirePackage{fancyhdr}
\pagestyle{fancy}
%\fancyhead{}
%\fancyhead[OR,EL]{Outer}
\fancypagestyle{plain}{\fancyhf{}\fancyhead[R]{Lol}}

% Define various mathematical stuff.
\RequirePackage{amsfonts}
\RequirePackage{amsmath}
\RequirePackage{amssymb}

% Various symbols (e.g. \degree)
\RequirePackage{gensymb}

% Provides \IfStrEqCase
\RequirePackage{xstring}

% Grow outer delimiters (like parentheses).
\delimitershortfall -1sp

% The 'dx' in '\int ... dx' or 'dy/dx'
% Use as \diff{x}
\newcommand*{\diff}[1]{\mathop{}\!\mathrm{d}#1}

% dy/dx
% Use as \Diff{y}{x}
\newcommand*{\Diff}[2]{\frac{\diff{#1}}{\diff{#2}}}

% Absolute value and norm.
\newcommand{\abs}[1]{\left\lvert#1\right\rvert}
\newcommand{\norm}[1]{\left\lVert#1\right\rVert}

% Norm for plain vectors.
\newcommand*{\vnorm}[1]{\norm{\vect{#1}}}

% LaTeX fails to reasonably render \Longrightarrow above 10pt.
% Use \Rightarrow instead.
% Do the same with \impliedby.
% From amsmath.sty
\renewcommand*{\implies}{\DOTSB\;\Rightarrow\;}
\renewcommand*{\impliedby}{\DOTSB\;\Leftarrow\;}

% Use vect for vectors.
\RequirePackage{bm}
\newcommand*{\vect}[1]{\boldsymbol{\mathbf{#1}}}

% Unit vectors.
\newcommand*{\uvect}[1]{%
  \hat{\vect{\IfStrEqCase{#1}{{i}{\imath}{j}{\jmath}}[#1]}}
}

% Vector dot product shortcut.
\newcommand*{\vectdot}[2]{\vect{#1} \cdot \vect{#2}}

% Vector projections.
\DeclareMathOperator{\proj}{proj}
\newcommand*{\vproj}[2]{\proj_{\vect{#1}} \left(\vect{#2}\right)}

% Vector distance.
\DeclareMathOperator{\vdist}{d}

% Vector cross product.
\newcommand*{\vcross}[2]{\vect{#1} \times \vect{#2}}

% Rays.
\newcommand*{\ray}[1]{\overrightarrow{#1}}

% Line segments.
\newcommand*{\lineseg}[1]{\overline{#1}}

% Augmented matrices.
% Taken mostly from <http://tex.stackexchange.com/a/2238>
%
% Usage:
% \begin{amatrix}{NUMBER OF COEFFICIENTS}
% ...
% \end{amatrix}
%
% Example:
% \begin{amatrix}{2}
% 1 & 2 & 3 \\
% a & b & c
% \end{amatrix}
\newenvironment{amatrix}[1]{%
  \left[\begin{array}{@{}*{#1}{c}|c@{}}
}{%
  \end{array}\right]
}

% Show matrix row operations.
% Taken almost completely from <http://tex.stackexchange.com/a/3149>
% Use like:
% \arrows{NUMBER OF ROWS}{ROW 1 OP}{ROW 2 OP}{}{ROW 4 OP}
% between two matrices.
% Note that this may not properly align vertically with the rows.
\newcount\arrowcount
\newcommand\arrows[1]{
        \global\arrowcount#1
        \ifnum\arrowcount>0
                \begin{matrix}
                \expandafter\nextarrow
        \fi
}
\newcommand\nextarrow[1]{
        \global\advance\arrowcount-1
        \ifx\relax#1\relax\else \xrightarrow{#1}\fi
        \ifnum\arrowcount=0
                \end{matrix}
        \else
                \\
                \expandafter\nextarrow
        \fi
}

% The vector span operator.
\DeclareMathOperator{\vspanop}{span}

% The vector span operator, but accepting an argument it wraps in parentheses.
\newcommand*{\vspan}[1]{\vspanop\left(#1\right)}

% Ceiling and floor functions.
% Use like: \floor*{x}
\RequirePackage{mathtools}
\DeclarePairedDelimiter{\ceil}{\lceil}{\rceil}
\DeclarePairedDelimiter{\floor}{\lfloor}{\rfloor}

% vim: set ft=tex:
