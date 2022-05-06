function fish_greeting
    echo Hello Ari!
    echo The time is (set_color yellow; date +%T; set_color normal) 
end

function cr
    if string match -q -e  -- "github.com" $argv[1]
        set -f owner (echo $argv | sed -e 's/.*github.com\/\([^\/]*\)\/.*/\1/g')
        set -f repo (echo $argv | sed -e 's/.*github.com\/[^\/]*\/\(.*\)\(\.git\)\?/\1/g')
        mkdir -p ~/$owner > /dev/null
        git clone -- $argv[1] ~/$owner/$repo
        cd ~/$owner/$repo
    else
        if string match -q -e -- "/" $argv[1]
            set -f owner (echo $argv | sed -e 's/\([^\/]*\)\/.*/\1/g')
            set -f repo (echo $argv | sed -e 's/[^\/]*\/\(.*\)/\1/g')
            mkdir -p ~/$owner > /dev/null
            gh repo clone $argv ~/$owner/$repo
            cd ~/$owner/$repo
        else
            set -f repo $argv[1]
            gh repo clone $argv ~/
            cd ~/$repo
        end
    end
end

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin

alias cat "batcat"
alias ls "exa --long --group-directories-first --no-permissions --no-user"
alias ps "procs"
alias vim "nvim"

cd ~/

if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
