use std::collections::HashMap;

fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
    };

    let mut count = HashMap::new();

    for (i, &c) in s.iter().enumerate() {
        count.entry(c).or_insert_with(Vec::new).push(i);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", count);

    let mut total = 0;

    for (&key, indexes) in &count {
        if indexes.len() < 2 {
            continue;
        }

        let mut values = Vec::new();
        let windows: Vec<_> = indexes.windows(2).collect();
        for window in windows {
            values.push(if window[1] - window[0] > 1 { window[1] - window[0] - 1 } else { 0 });
            values.push(1);
        }
        values.pop();

        #[cfg(debug_assertions)]
        eprintln!("{:?}", &values);

        let mut accs = vec![0];
        for value in values {
            accs.push(accs.last().unwrap_or(&0) + value);
        }

        #[cfg(debug_assertions)]
        eprintln!("{:?}", (key, &accs));

        total += accs.iter().sum::<usize>();
    }

    println!("{}", total);
}
