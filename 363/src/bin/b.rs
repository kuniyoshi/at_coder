fn main() {
    proconio::input! {
        n: usize,
        t: u64,
        p: usize,
        mut l: [u64; n],
    };

    l.sort();
    l.reverse();

    if l[p - 1] > t {
        println!("{}", 0);
    } else {
        println!("{}", t - l[p - 1]);
    }
}
