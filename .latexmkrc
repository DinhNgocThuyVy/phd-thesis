# Custom latexmk configuration to optimize LaTeX compilation
$pdf_mode = 1;           # Use pdflatex
$max_repeat = 12;        # Maximum compilation attempts
$preview_continuous_mode = 0;
$bibtex_use = 2;         # Run bibtex/biber when needed

# Add custom dependencies for improved reference tracking
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
  system("makeglossaries '$_[0]'");
}
