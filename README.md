# `knit-deleting-service-files()`

#### Function for knitting (R) Markdown documents while circumventing common errors. The function deletes service files and folders (e.g., `.tex`, `doc_files`) before and after knitting an Rmd/md document.

### Longer description

This function is designed to avoid errors when knitting (i.e., rendering) Markdown or R Markdown documents that are due to service files remaining from previous knittings (e.g., manuscript.tex, ZHJhZnQtYXBhLlJtZA==.Rmd, manuscript.synctex.gz). The function first suggests deleting potential service files in the directory. A response from the user is required in the console. Next, the document is knitted. Last, the function offers deleting potential service files again, with a response being required again. The only obligatory argument of this function is the name of an (R)md file. The optional argument is a path to the directory in which the file is located. 


![Screenshot 2021-12-15 at 19 32 02](https://user-images.githubusercontent.com/20436359/146609256-4003e074-8f9c-489a-b530-8759f157b737.png)
