fn main() {
    proconio::input! {
        s: [String; 12],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", &s);

    println!(
        "{}",
        s.iter()
            .enumerate()
            .filter(|(i, chars)| chars.len() == *i + 1)
            .count()
    );
}
