function o --description 'Open file/directory with default program for file type'
    switch (uname)
        case Darwin # on Mac
            open $argv
        case Linux # on WSL
            wsl-open $argv
    end
end
