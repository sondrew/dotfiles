function copy --description 'Copy standard output to clipboard'
    switch (uname)
        case Linux # on WSL - on linux use xclip/xsel
            $argv | clip.exe
        case Darwin # on Mac
            $argv | pbcopy
    end
end
