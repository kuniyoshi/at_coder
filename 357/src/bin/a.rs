fn main() {
    proconio::input! {
        n: usize,
        m: usize,
        h: [usize; n],
    };

    let mut total_hands = 0;

    for i in 0..n {
        if total_hands + h[i] > m {
            println!("{}", i);
            return ();
        }
        total_hands += h[i];
    }

    println!("{}", n);
}
