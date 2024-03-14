use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    let mut max = 1;

    for i in 1..10_000_000 {
        if i * i * i > n {
            break;
        }

        if is_kaibun(i * i * i) {
            max = i * i * i;
        }
    }

    println!("{}", max);
}

fn is_kaibun(a: usize) -> bool {
    let s = a.to_string().chars().collect::<Vec<char>>();
    let mut r = s.clone();
    r.reverse();

    // #[cfg(debug_assertions)]
    // eprintln!("{:?}", s);

    // #[cfg(debug_assertions)]
    // eprintln!("{:?}", r);

    // TODO: 文字列テストバージョンも試す

    for i in 0..s.len() {
        if r[i] != s[i] {
            return false;
        }
    }

    true

    // TODO: char テストバージョンも試す
    // for i in 0..(s.len() / 2) {
    //     if s[i] != s[s.len() - i - 1] {
    //         return false;
    //     }
    // }

    // true
}