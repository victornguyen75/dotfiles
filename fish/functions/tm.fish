function tm --description 'Attach to an existing tmux session, or create one named after the current directory'
    set -l name $argv[1]
    if test -z "$name"
        set name (basename $PWD | string replace -a . _)
    end

    if not set -q TMUX
        if tmux has-session -t $name 2>/dev/null
            tmux attach-session -t $name
        else
            tmux new-session -s $name -c $PWD
        end
    else
        if tmux has-session -t $name 2>/dev/null
            tmux switch-client -t $name
        else
            tmux new-session -d -s $name -c $PWD
            tmux switch-client -t $name
        end
    end
end
