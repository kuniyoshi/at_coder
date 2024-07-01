fn main() {
    proconio::input! {
        s: String,
        t: String,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (&s, &t));

    if s.eq("AtCoder") && t.eq("Land") {
        println!("Yes");
    } else {
        println!("No");
    }
}
