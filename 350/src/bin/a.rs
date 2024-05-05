fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
    };

    let t: usize = s[3..6].iter().collect::<String>().parse().unwrap();

    if t != 316 && 0 < t && t < 350 {
        println!("Yes");
    } else {
        println!("No");
    }
}
