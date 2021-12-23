

# Function for knitting (R) Markdown documents while circumventing common errors. The function offers deleting
# potential service files and folders before and after knitting an Rmd/md document.

# Longer description
# The function knit_deleting_service_files() helps avoid (R) Markdown knitting errors caused by files and 
# folders remaining from previous knittings (e.g., manuscript.tex, ZHJhZnQtYXBhLlJtZA==.Rmd, 
# manuscript.synctex.gz). The only obligatory argument for this function is the name of a .Rmd or .md file. 
# The optional argument is a path to a directory containing this file.
#
# The function first offers deleting potential service files and folders, for which the user's approval is 
# requested in the console. Next, the document is knitted. Last, the function offers deleting potential 
# service files and folders again.
# 
# NOTE: The deletions, if accepted, are irreversible as they are made through `unlink()`
# (https://stat.ethz.ch/R-manual/R-devel/library/base/html/unlink.html). Therefore, our familiar 
# adage truly applies: this function comes with ABSOLUTELY NO WARRANTY. Please ensure you 
# understand the source code before using the function
# (https://github.com/pablobernabeu/knit-deleting-service-files/blob/main/knit_deleting_service_files.R).


knit_deleting_service_files =
  
  function(file_name_with_extension, path = NULL) {
    
    require(rmarkdown)
    
    # Input validity: check if file_name_with_extension provided by user has the extension 
    # '.md' or 'Rmd' and exists in the directory. If it does not, stop function with error.
    # In the latter check, if path was provided by user, specify it in list.files()
    if(!endsWith(file_name_with_extension, '.md') & !endsWith(file_name_with_extension, '.Rmd')) {
      stop('The file must have the extension .Rmd or .md, and this extension must be specified.')
    }
    
    # If path not provided, look for the file in the current directory
    if(is.null(path) & !file_name_with_extension %in% list.files()) {
      stop('File not found.')
      
      # If path provided, look for file there
    } else if(!is.null(path)) {
      if(!file_name_with_extension %in% list.files(path = path)) {
        stop('File not found.')
      }}
    
    # Create function to find potential service files 
    # and folders in the appropriate directory.
    find_service_files_folders = 
      function() {
        
        # If no path provided by user, use default (current) directory
        if(is.null(path)) {
          list.files(
            # any files or folders with any of the four endings below
            pattern = paste0('^.*(\\.tex|\\.log|\\.synctex.gz|\\.out|\\.aux|\\=.Rmd|',
                             # or named exactly [name]_files. Below, to define [name]_files,
                             # the extensions .md or .Rmd are removed from 
                             # `file_name_with_extension`. Let the result be `[name]`. Any 
                             # files or folders called '[name]_files' will be stored, along
                             # with the other files specified right above. 
                             paste0(sub('*\\.(Rmd|md)', '', file_name_with_extension), '_files)$'))
          )
          
          # else, specify path in list.files()
        } else {
          list.files( path = path,
                      # any files or folders with any of the four endings below
                      pattern = paste0('^.*(\\.tex|\\.log|\\.synctex.gz|\\.out|\\.aux|\\=.Rmd|',
                                       # or named exactly [name]_files. Below, to define [name]_files,
                                       # the extensions .md or .Rmd are removed from 
                                       # `file_name_with_extension`. Let the result be `[name]`. Any 
                                       # files or folders called '[name]_files' will be stored, along
                                       # with the other files specified right above. 
                                       paste0(sub('*\\.(Rmd|md)', '', file_name_with_extension), '_files)$'))
          )
        }
      }
    
    # Initial purge of service files/folders to avoid knitting errors.
    # If knit_deleting_service_files() now finds some service files or folders, 
    # request approval for deletion (3 steps used below).
    if(length(find_service_files_folders()) > 0) {
      
      # 1. Store names of any service files and folders...
      # If no path provided by user, store names as they are
      if(is.null(path)) {
        initial_service_files_folders = find_service_files_folders()
        
        # else, add path at the beginning of the names
      } else initial_service_files_folders = paste0(path, '/', find_service_files_folders())
      
      # 2. Request user's approval of these deletions
      message('\n Response required below')
      approval_initial_service_files_folders = 
        readline(prompt = cat(
          paste0('\n DELETE the files or folders below irreversibly?\n',
                 # Remark on the directory
                 if(!is.null(path)) paste0(" (enclosing directory shown before slash)\n"), 
                 paste0('\n  - ', initial_service_files_folders, collapse = ''), 
                 "\n\n To delete these files or folders irreversibly, press 'y' and Enter.\n",
                 " Press any other letter and Enter to continue without deleting.\n\n")
        ))
      
      # 3. If approved, DELETE service files and folders
      if(approval_initial_service_files_folders == 'y') {
        unlink(initial_service_files_folders, recursive = TRUE, force = TRUE)
        message('Files or folders deleted. Knitting document...')
        
      } else message('No service files or folders deleted. Knitting document...')
    }
    
    
    # KNIT document
    # If path not provided...
    if(is.null(path)) {
      rmarkdown::render(file_name_with_extension)
      # else...
    } else rmarkdown::render(paste0(path, '/', file_name_with_extension))
    
    
    # Final purge of service files/folders to avoid knitting errors in subsequent attempts.
    # If knit_deleting_service_files() now finds some service files or folders...
    if(length(find_service_files_folders()) > 0) {
      
      # Store names of any service files and folders...
      # If no path provided by user, store names as they are
      if(is.null(path)) {
        final_service_files_folders = find_service_files_folders()
        
        # else, add path at the beginning of the names
      } else final_service_files_folders = paste0(path, '/', find_service_files_folders())
      
      # Request user's approval of these deletions
      message('\n Response required below')
      approval_final_service_files_folders = 
        readline(prompt = cat(
          paste0('\n DELETE the files or folders below irreversibly?\n',
                 # Remark on the directory
                 if(!is.null(path)) paste0(" (enclosing directory shown before slash)\n"), 
                 paste0('\n  - ', final_service_files_folders, collapse = ''), 
                 "\n\n To delete these files or folders irreversibly, press 'y' and Enter.\n",
                 " Press any other letter and Enter to finish without deleting.\n\n")
        ))
      
      # If approved, DELETE service files and folders
      if(approval_final_service_files_folders == 'y') {
        unlink(final_service_files_folders, recursive = TRUE, force = TRUE)
        message('Files or folders deleted. Task completed.')
        
        # else, finish task
      } else message('Task completed.')
    }
  }

