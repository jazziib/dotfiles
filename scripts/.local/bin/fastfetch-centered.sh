#!/usr/bin/env bash
# fastfetch-centered.sh: horizontally centers fastfetch output in the terminal

# Simulates the cursor per line: counts printable chars, honours ESC[nC (forward)
# and ESC[nD (back), ignores colors/other CSI. Prints the max column reached.
measure_width() {
    perl -CSD -ne '
        BEGIN { $max = 0 }
        chomp; $col = 0;
        while (length) {
            if (s/^\e\[([0-9;:?]*)([@-~])//) {
                ($n, $c) = ($1, $2);
                if    ($c eq "C") { $col += ($n eq "" ? 1 : $n) }
                elsif ($c eq "D") { $col -= ($n eq "" ? 1 : $n); $col = 0 if $col < 0 }
            }
            elsif (s/^(.)//s) { $col++ }
            $max = $col if $col > $max;
        }
        END { print $max }
    '
}

output="$(fastfetch --pipe false "$@")"
max_width=$(measure_width <<< "$output")

term_width=$(tput cols)
pad=$(( (term_width - max_width) / 2 ))
(( pad < 0 )) && pad=0
padding=$(printf '%*s' "$pad" '')

while IFS= read -r line; do
    printf '%s%s\n' "$padding" "$line"
done <<< "$output"
