if status is-interactive
    # Commands to run in interactive sessions can go here
end
zoxide init fish | source

function lf
    EDITOR=helix command lf $argv
end
