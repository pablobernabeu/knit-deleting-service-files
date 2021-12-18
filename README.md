# `knit_deleting_service_files()`: A function for knitting (R) Markdown documents without errors due to service files

The function `knit_deleting_service_files()` helps avoid (R) Markdown knitting errors caused by files and folders remaining from previous knittings (e.g., manuscript.tex, ZHJhZnQtYXBhLlJtZA==.Rmd, manuscript.synctex.gz). The only obligatory argument for this function is the name of a `.Rmd` or `.md` file. The optional argument is a path to a directory containing this file.

The function first offers deleting potential service files and folders in the directory. A confirmation is required in the console (see screenshot below). Next, the document is knitted. Last, the function offers deleting potential service files and folders again.

NOTE: The deletions, if accepted, are irreversible as they are made through [`unlink()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/unlink.html). Therefore, our familiar adage truly applies: this function comes with ABSOLUTELY NO WARRANTY. Please ensure you understand the [source code](https://github.com/pablobernabeu/knit_deleting_service_files/blob/main/knit_deleting_service_files.R) before using the function.

<br>

![Screenshot 2021-12-18 at 20 27 49](https://user-images.githubusercontent.com/20436359/146654775-b7d0b5e0-c183-4bf7-8436-7c4022241a4c.png)

