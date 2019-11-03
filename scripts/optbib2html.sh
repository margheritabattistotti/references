#!/bin/sh
if [ ! -e biblio.bib ]; then
    echo "$0: error: cannot find biblio.bib !"
    exit 1
fi

tmpbib=$(mktemp --tmpdir tmpXXXXXXXXXX.bib)
tmpcitefile=$(mktemp --tmpdir citefileXXXXXXXXXX)

bib2bib --warn-error --expand --expand-xrefs authors.bib abbrev.bib journals.bib biblio.bib crossref.bib -ob $tmpbib -oc $tmpcitefile

cd web
bibtex2html --title "IRIDIA BibTeX Repository" --html-entities -linebreak -css bibtex.css --named-field url http --named-field springerlink Springer --named-field supplement "supplementary material" --named-field pdf PDF -dl -u -s ../bibstyles/plainweb -macros-from ../macros.tex -o index -citefile $tmpcitefile $tmpbib

# remove temporary files
rm -f bib2html*
cd ..
