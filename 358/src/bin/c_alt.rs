fn main() {
    proconio::input! {
        n: usize,
        m: usize,
        s: [proconio::marker::Chars; n],
    };

    let taste_sets: Vec<_> = s.iter().map(|chars| bits(chars)).collect();

    let mut min = n;

    for i in 0..(1 << n) {
        let mut set = 0;
        let mut buys = 0;

        for j in 0..n {
            if (i & 1 << j) > 0 {
                set |= taste_sets[j];
                buys += 1;
            }
        }

        if set == (1 << m) - 1 {
            min = min.min(buys);
        }
    }

    println!("{}", min);
}

fn bits(chars: &Vec<char>) -> u64 {
    let mut result = 0;

    for i in 0..chars.len() {
        if chars[i] == 'o' {
            result |= 1 << i;
        }
    }

    result
}