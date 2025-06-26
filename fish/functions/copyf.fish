function copyf --description 'Copy content of file to clipboard'
cat $argv | pbcopy
end
