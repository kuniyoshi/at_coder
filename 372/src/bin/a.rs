fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
    };

    for c in s.iter().filter(|c| c != &&'.') {
        print!("{}", c);
    }

    println!("");
}
