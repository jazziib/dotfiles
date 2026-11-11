function fastfetch-centered
    set -l output (fastfetch --pipe false 2>/dev/null)
    set -l term_width $COLUMNS
    test -z "$term_width"; and set term_width (tput cols)

    set -l max_width (printf "%s\n" $output | perl -CS -ne '
        chomp;
        my $w = 0;
        while (length($_)) {
            if    (s/^\x1b\[(\d+)C//) { $w += $1; }
            elsif (s/^\x1b\[(\d+)D//) { $w -= $1; }
            elsif (s/^\x1b\[[0-9;?]*[A-Za-z]//) { }
            else  { s/^(.)//s; $w++; }
        }
        $max = $w if $w > ($max // 0);
        END { print($max // 0); }
    ')

    set -l pad (math --scale=0 "max(0, ($term_width - $max_width) / 2)")

    for line in $output
        printf "%*s%s\n" $pad "" "$line"
    end
end

