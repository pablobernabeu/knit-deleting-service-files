# `knit_deleting_service_files()`

Function for knitting (R) Markdown documents while circumventing common errors. The function offers deleting potential service files and folders (e.g., `.tex`, `doc_files`) before and after knitting an (R)md document.

### Longer description

The function `knit_deleting_service_files()` helps avoid (R) Markdown knitting errors caused by files and folders remaining from previous knittings (e.g., manuscript.tex, ZHJhZnQtYXBhLlJtZA==.Rmd, manuscript.synctex.gz). The function first offers deleting potential service files in the directory. A response from the user is required in the console. Next, the document is knitted. Last, the function offers deleting potential service files again, with a response being required as well. The only obligatory argument for this function is the name of an (R)md file. The optional argument is a path to a directory containing the file.

NOTE: The deletion, if accepted, is irreversible as it is made through [`unlink()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/unlink.html). Therefore, our familiar adage truly applies: this function comes with ABSOLUTELY NO WARRANTY. Please ensure you understand the [source code](https://github.com/pablobernabeu/knit_deleting_service_files/blob/main/knit_deleting_service_files.R) before using the function.

<br>

![Screenshot 2021-12-15 at 19 32 02](https://user-images.githubusercontent.com/20436359/146609256-4003e074-8f9c-489a-b530-8759f157b737.png)
