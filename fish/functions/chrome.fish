function chrome --description 'Open file in Chrome'
    switch (uname)
        case Darwin # on Mac
            open -a "Google Chrome" $argv
        case Linux # on WSL
            /mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe $argv
    end
end
