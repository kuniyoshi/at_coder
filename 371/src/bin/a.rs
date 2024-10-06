fn main() {
    proconio::input! {
        ab: char,
        ac: char,
        bc: char,
    };

    match (ab, ac, bc) {
        ('>', '>', '>') => println!("B"), // c < b < a
        ('>', '>', '<') => println!("C"), // b < c < a
        ('>', '<', '>') => unreachable!(),
        ('>', '<', '<') => println!("A"), // b < a < c
        ('<', '>', '>') => println!("A"), // c < a < b
        ('<', '>', '<') => unreachable!(),
        ('<', '<', '>') => println!("C"), // a < c < b
        ('<', '<', '<') => println!("B"), // a < b < c
        _ => unreachable!(),
    };
}
