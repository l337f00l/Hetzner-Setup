#!/bin/bash
# --- -------------------------------- --- #
# FUNC:  Process a folder of files
# --- -------------------------------- --- #
# Scripted by l337f00l #
sfv_check() {
        cfv -M
}

func_process_folder_set(){
        dir="$1"

        while read -rd $'\0' file; do
                fileext=${file##*.}  # -- get the .ext of file
                echo "FILE: $file"
                filedir=$(dirname "$file")
                filedirname=$(basename "$filedir")
                ( cd "$filedir" && sfv_check) || {
                        echo sfv check failed in "$filedir"
                        continue
                }
                tar cf "${2}/${filedirname}.tar" "$filedirname" -C "${filedir}/.." --remove-files
        done < <(find  "$dir" -maxdepth 2 -type f -name '*.sfv' -print0)
}

# -- call the function above with this:
func_process_folder_set "/media/sdm1/l337f00l/Music-Stage" "/media/sdm1/l337f00l/AA-Music01/"
