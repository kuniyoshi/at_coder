fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
        t: proconio::marker::Chars,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", s);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", t);

    let t_alt: Vec<_> = if t.last().unwrap() == &'X' { t[0..=1].iter().collect() } else { t.iter().collect() };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", t_alt);

    let mut index = 0;

    for c in &s {
        if &c.to_ascii_uppercase() == t_alt[index] {
            index += 1;

            if index >= t_alt.len() {
                println!("Yes");
                return ();
            }
        }
    }

    println!("No");
}
