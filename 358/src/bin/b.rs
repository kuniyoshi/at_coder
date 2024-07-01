fn main() {
    proconio::input! {
        n: usize,
        a: u64,
        t: [u64; n],
    };

    let mut time = 0;

    for arrive in &t {
        time = time.max(*arrive);

        println!("{}", time + a);
        time += a;
    }
}
