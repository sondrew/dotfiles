function sub --description 'Open file in Sublime Text editor'
    switch (uname)
        case Darwin # on Mac
            open -a 'Sublime Text' $argv
        case Linux # on WSL
            /mnt/c/Program\ Files/Sublime\ Text\ 3/subl.exe $argv
    end
end
