function fish_prompt --description 'Write out the prompt'
    set --local stat $status

    set __prompt_color_status (set_color -o green)
    if test $stat -gt 0
        set __prompt_color_status (set_color -o red)
    end

    printf '%s %s%s@%s%s:%s%s%s %s$%s ' \
        (date "+%H:%M") \
        (set_color green) \
        $USER \
        (prompt_hostname) \
        (set_color normal) \
        (set_color green) \
        (set_color blue) \
        "$PWD" \
        "$__prompt_color_status" \
        (set_color normal)
end