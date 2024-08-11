fn main() {
    proconio::input! {
        n: usize,
        tastes: [String; n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", tastes);

    let index = tastes.windows(2).position(|l| l[0] == l[1] && l[0] == "sweet");
    #[cfg(debug_assertions)]
    eprintln!("{:?}", index);

    match index {
        None => println!("Yes"),
        Some(v) if v == n - 2 => println!("Yes"),
        _ => println!("No"),
    };
}
