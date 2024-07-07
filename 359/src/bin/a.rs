fn main() {
    proconio::input! {
        n: usize,
        names: [String; n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", names);

    println!("{}", names.iter().filter(|name| name == &"Takahashi").count());
}
