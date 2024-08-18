fn main() {
    proconio::input! {
        n: usize,
        _a: [u64; n],
    };

    let mut s = vec![0; n];

    for i in 0..n {
        s[i] += n - i - 1;
        if i < n - 1 {
            s[i + 1] += n - i - 1;
        }

        s[i] += i.checked_sub(1).unwrap_or(0);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", s);
}
