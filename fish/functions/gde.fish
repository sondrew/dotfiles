function gde --description 'git diff excluding files given as arguments'
    set cmd "git diff -- ."
    for arg in $argv
        set cmd "$cmd ':(exclude)$arg'"
    end
    $cmd
end
