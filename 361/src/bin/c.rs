fn main() {
    proconio::input! {
        n: usize,
        k: u64,
        mut a: [u64; n],
    };

    a.sort();

    let mut p1 = 0;
    let mut p2 = n - 1;

    for i in 0..k {
        if (a[p1 + (k - i) as usize] - a[p1]) > (a[p2] - a[p2 - (k - i) as usize]) {
            p1 += 1;
        } else {
            p2 -= 1;
        }
    }

    println!("{}", a[p2] - a[p1]);
}
