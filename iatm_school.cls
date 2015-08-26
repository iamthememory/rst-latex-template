% Base this on the article class.
\LoadClass[letterpaper,twoside,12pt]{article}

% Basic dependency stuff.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iatm_school}[2015/08/25 rst2latex class for notes and homework]

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

% Use the T1 font encoding
\RequirePackage[T1]{fontenc}

% Use DejaVu Sans Mono for code and such.
% Make sure it's shrunk a bit, so 80-char lines of code don't run too far past
% the margins.
\RequirePackage[scaled=0.8]{DejaVuSansMono}

% Use French spacing (no double spaces after a sentence).
\frenchspacing

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
% Grow outer delimiters (like parentheses).
\delimitershortfall -1sp
% The 'dx' in '\int ... dx' or 'dy/dx'
% Use as \diff{x}
\newcommand*{\diff}[1]{\mathop{}\!\mathrm{d}#1}
% dy/dx
% Use as \Diff{y}{x}
\newcommand*{\Diff}[2]{\frac{\diff{#1}}{\diff{#2}}}
% Absolute value
\newcommand*{\abs}[1]{\left|#1\right|}
% LaTeX fails to reasonably render \Longrightarrow above 10pt.
% Use \Rightarrow instead.
% From amsmath.sty
\renewcommand*{\implies}{\DOTSB\;\Rightarrow\;}

% vim: set ft=tex:
