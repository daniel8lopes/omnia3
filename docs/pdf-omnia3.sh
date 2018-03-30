echo 'Killing all Jekyll instances'
kill -9 $(ps aux | grep '[j]ekyll' | awk '{print $2}')
clear

echo "Building PDF-friendly HTML site for OMNIA3 ...";
bundle exec jekyll serve --detach --config _config.yml,pdfconfigs/config_omnia3_pdf.yml;
echo "done";

echo "Building the PDF ...";
prince --javascript --input-list=_site/pdfconfigs/prince-list.txt -o pdf/omnia3.pdf;
echo "done";
