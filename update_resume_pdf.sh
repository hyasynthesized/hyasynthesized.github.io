sed 's/^.*PDF copy.*$//g;s/title = "\(.*\)"/# \1/g;s/+++//g;s/\[\(.*\)\](\(.*\))/\1 (\2)/g' content/resume.md | pandoc --pdf-engine=typst -o content/resume.pdf
