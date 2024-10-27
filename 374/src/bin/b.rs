fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
        t: proconio::marker::Chars,
    };

    let position = (0..(s.len().min(t.len()))).find(|i| s[*i] != t[*i]);

    if position.is_some() {
        println!("{}", position.unwrap() + 1);
        return;
    }

    if s.len() != t.len() {
        println!("{}", s.len().min(t.len()) + 1);
    } else {
        println!("{}", 0);
    }
}
