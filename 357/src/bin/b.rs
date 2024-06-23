fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
    };

    let uppers = s.iter().filter(|c| c.is_uppercase()).count();
    let lowers = s.iter().filter(|c| c.is_lowercase()).count();

    if uppers > lowers {
        let t: Vec<_> = s.iter().map(|c| c.to_uppercase()).collect();
        for c in t {
            print!("{}", c);
        }
        println!();
    } else {
        let t: Vec<_> = s.iter().map(|c| c.to_lowercase()).collect();
        for c in t {
            print!("{}", c);
        }
        println!();
    }
}
