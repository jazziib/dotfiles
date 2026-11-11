function fastfetch-centered
    set output (fastfetch --pipe false 2>/dev/null)
    set term_width (tput cols)
    set max_width 0

    for line in $output
        set w (perl -e '
            my $s = $ARGV[0];
            my $width = 0;
            while (length($s)) {
                if    ($s =~ s/^\x1b\[(\d+)C//) { $width += $1; }
                elsif ($s =~ s/^\x1b\[(\d+)D//) { $width -= $1; }
                elsif ($s =~ s/^\x1b\[[0-9;]*[A-Za-z]//) { }
                else  { $s =~ s/^(.)//s; $width++; }
            }
            print $width;
        ' -- $line)
        if test $w -gt $max_width
            set max_width $w
        end
    end

    set pad (math "($term_width - $max_width) / 2")
    if test $pad -lt 0
        set pad 0
    end

    for line in $output
        printf "%*s%s\n" $pad "" "$line"
    end
end
