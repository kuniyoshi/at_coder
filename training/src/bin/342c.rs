fn main() {
    proconio::input! {
        _: usize,
        s: proconio::marker::Chars,
        q: usize,
        queries: [(char, char); q],
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", queries);

    let mut chars: Vec<_> = ('a'..='z').collect();
    #[cfg(debug_assertions)]
    eprintln!("{:?}", chars);

    for (from, to) in queries {
        for i in 0..chars.len() {
            if chars[i] == from {
                chars[i] = to;
            }
        }
    }

    for i in 0..s.len() {
        print!("{}", chars[(s[i] as usize) - ('a' as usize)]);
    }
    println!("");
}
