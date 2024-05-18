fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
        t: proconio::marker::Chars,
    };

    let mut cursor = 0;

    for i in 0..t.len() {
        if t[i] == s[cursor] {
            print!("{} ", i + 1);
            cursor += 1;
        }
    }

    println!("");
}
