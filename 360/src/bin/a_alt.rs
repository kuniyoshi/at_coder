fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
    };

    let r = s.iter().position(|c| c == &'R').unwrap_or(0);
    let m = s.iter().position(|c| c == &'M').unwrap_or(0);

    if r < m {
        println!("Yes");
    } else {
        println!("No");
    }
}
