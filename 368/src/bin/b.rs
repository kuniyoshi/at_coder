fn main() {
    proconio::input! {
        n: usize,
        mut a: [u64; n],
    };

    let mut count = 0;

    loop {
        a.sort();
        a.reverse();

        a[0] -= 1;
        a[1] -= 1;

        count += 1;

        if a.iter().filter(|&&v| v > 0).count() <= 1 {
            break;
        }
    }

    println!("{}", count);
}
