fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
        t: proconio::marker::Chars,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", s);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", t);

    let mut matches_l = vec![false; t.len() + 1];
    let mut matches_r = vec![false; t.len() + 1];

    for i in 0..(t.len() + 1) {
        matches_l[i] = *matches_l.get(i - 1).unwrap_or(&true) && s[i] == t[i];
    }

    let mut i = 0;

    loop {
        

        i += 1;
        if i > t.len() {
            break;
        }
    }
}