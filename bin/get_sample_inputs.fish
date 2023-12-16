#!/usr/bin/env fish
function get_sample_inputs -a number problem
    set contest "abc$number"
    set url "https://atcoder.jp/contests/$contest/tasks/$contest"_"$problem"
    echo "url: $url" >&2

    set temp "/tmp/atcoder.$contest.$problem.html"

    curl -s $url >$temp
    echo "saved into: $temp"

    mkdir -p $number/data

    for sample_number in (perl -lne 'm{入力例 (\d)} and print $1' $temp)
        echo $sample_number
        perl -e 'my $html = do { local $/; <> }; print $html =~ m{\Q<h3>入力例 '$sample_number'</h3><pre>\E(.*?)\Q</pre>}msx' $temp \
            >$number/data/$problem.$sample_number
    end
end

get_sample_inputs $argv[1] $argv[2]
