fn main() {
    proconio::input! {
        n: usize,
        a: [proconio::marker::Chars; n],
        b: [proconio::marker::Chars; n],
    };

    for i in 0..n {
        for j in 0..n {
            if a[i][j] != b[i][j] {
                println!("{} {}", i + 1, j + 1);
            }
        }
    }
}
