fn main() {
    proconio::input! {
        n: usize,
        mut s: proconio::marker::Chars,
        c: [usize; n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", s);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", c);

    (0..s.len())
        .filter(|i| i % 2 == 1)
        .for_each(|i| s[i] = flip(s[i]));

    #[cfg(debug_assertions)]
    eprintln!("{:?}", s);

    let mut l_scores = vec![0; n + 1];
    let mut r_scores = vec![0; n + 1];

    for (i, char) in s.iter().enumerate() {
        if char == &'0' {
            continue;
        }
        l_scores[i + 1] = l_scores[i] + c[i];
    }

    for (i, char) in s.iter().rev().enumerate() {
        if char == &'0' {
            continue;
        }
        r_scores[i + 1] = r_scores[i] + c[i];
    }
}

fn flip(c: char) -> char {
    char::from(('0' as usize + (c as usize - '0' as usize) ^ 1) as u8)
}
