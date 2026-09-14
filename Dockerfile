FROM sotetsuk/pdflatex

WORKDIR /resume

COPY src/ ./src/

WORKDIR /resume/src

CMD ["pdflatex", "-file-line-error", "-halt-on-error", "-output-directory=../out", "./webresume.tex"]
