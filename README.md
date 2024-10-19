# Building

First compilation

```bash
xelatex -shell-escape main.tex \
    && biber main \
    && xelatex -shell-escape main.tex \
    && xelatex -shell-escape main.tex
```

Compilation

```bash
biber main && xelatex -shell-escape main.tex
```
