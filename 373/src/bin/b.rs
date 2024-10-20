fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
    };

    let mut cursor = s.iter().position(|c| c == &'A').unwrap() as i32;
    let mut distance = 0;

    for char in "BCDEFGHIJKLMNOPQRSTUVWXYZ".chars() { // TODO: A を含めて書いたらどうなるか？
        let next = s.iter().position(|c| c == &char).unwrap() as i32;
        distance += (next - cursor).abs();
        cursor = next;
    }

    println!("{}", distance);
}
