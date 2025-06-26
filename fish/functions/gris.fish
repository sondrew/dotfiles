function gris --description 'stash changes, interactive rebase by x, pop stash'
    if test (count $argv) -ne 1
        echo "Usage: gris <number-of-commits-to-rebase>"
        return 1
    end

    if not string match -qr '^\d+$' -- $argv[1]
        echo "Error: argument must be a positive number"
        return 1
    end

    set rebase_target HEAD~$argv[1]

    echo "Stashing changes..."
    git stash push -m "Temp stash by gris"

    echo "Starting interactive rebase at $rebase_target..."
    git rebase -i $rebase_target

    if test $status -eq 0
        echo "Rebase successful. Popping stash..."
        git stash pop
    else
        echo "Rebase failed or aborted. Keeping stash intact."
    end
end
