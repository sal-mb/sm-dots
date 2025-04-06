if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
zoxide init fish | source

set -gx EDITOR helix
set -gx TERM wezterm

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

fish_vi_key_bindings
