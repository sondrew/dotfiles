function copy --description 'Copy standard output to clipboard'
    switch (uname)
        case Linux # on WSL - on linux use xclip/xsel
            eval $argv | clip.exe
        case Darwin # on Mac
            eval $argv | pbcopy
    end
end
