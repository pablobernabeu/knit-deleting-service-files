# knit-deleting-service-files
This function is designed to avoid errors when knitting (i.e., rendering) Markdown or R Markdown documents due to service files remaining from previous knittings. First, if potential service files exist in the directory, it offers deleting them. Next, it knits the document. Last, it offers deleting any service files again.
