function gae --description 'git add all files excluding those given as arguments'
    set cmd "git add . --"
    for arg in $argv
        set cmd "$cmd ':(exclude)$arg'"
    end
    $cmd
end
