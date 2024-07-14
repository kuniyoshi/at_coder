fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
    };

    for c in &s {
        match c {
            'R' => {
                println!("Yes");
                return ();
            },
            'M' => {
                println!("No");
                return ();
            },
            _ => (),
        };
    }
}
