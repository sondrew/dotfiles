function cpy --description 'Copy current filepath to clipboard'
    switch (uname)
         case Linux # on WSL - on
             pwd | clip.exe
         case Darwin # on Mac
            pwd | pbcopy
    end
end
