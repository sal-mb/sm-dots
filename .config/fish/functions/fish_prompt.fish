function vi_mode_prompt
    set_color --bold magenta
    switch $fish_bind_mode
        case default
            # # Normal mode (default)
            # set_color --bold blue
            echo -n '[]' # You can replace this with any suitable symbol or text.
        case insert
            # # Insert mode
            # set_color --bold green
            echo -n '[]' # Insert mode symbol
        case replace_one
            # # Replace one character
            # set_color --bold yellow
            echo -n '[]' # Replace symbol
        case visual
            # Visual mode
            set_color --bold magenta
            echo -n '[⇌]' # Visual mode symbol
        case '*'
            # Unknown mode (Fallback)
            set_color --bold red
            echo -n '[?]'
    end
    set_color normal
end

function fish_prompt
    vi_mode_prompt

    if git rev-parse --git-dir >/dev/null 2>&1
        echo -n "  "
    end

    if test -n "$SSH_TTY"
        echo -n (set_color brred)" $USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
    end

    echo -n " "(set_color blue)(prompt_pwd)' '

    set_color -o
    if fish_is_root_user
        echo -n (set_color red)'# '
    end
    echo -n (set_color green)'❯ '
    set_color normal
end
