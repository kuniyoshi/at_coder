fn main() {
    proconio::input! {
        n: usize,
        mut s: [proconio::marker::Chars; n],
    };

    s.reverse();

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, &s));

    for i in 0..s.iter().map(|t| t.len()).max().unwrap_or(0) {
        let max = (0..n).filter(|j| s[*j].len() - 1 >= i).max().unwrap_or(0);
        let line = (0..n).filter(|j| j <= &max).map(|j| s[j].get(i).unwrap_or(&'*')).collect::<String>();
        println!("{}", line);
    }
}
