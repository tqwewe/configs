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

function dev
    node ~/.scripts/dev.js | bash
end

function wslip
    ip -4 addr show eth0
end

function fish_user_key_bindings
    bind \e\[1\;5D backward-word
    bind \e\[1\;5C forward-word
    bind \b backward-kill-word
end

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path /usr/share/swift/usr/bin

set -gx GPG_TTY $(tty)

alias cat "batcat"
alias ls "exa --long --group-directories-first --no-permissions --no-user"
alias ps "procs"
alias vim "nvim"

if status is-interactive
end

starship init fish | source

# Wasienv
export WASIENV_DIR="/home/ari/.wasienv"
[ -s "$WASIENV_DIR/wasienv.sh" ] && source "$WASIENV_DIR/wasienv.sh"

# Wasmer
export WASMER_DIR="/home/ari/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
