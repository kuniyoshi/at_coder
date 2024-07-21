fn main() {
    proconio::input! {
        n: usize,
        k: usize,
        x: u64,
        a: [u64; n],
    };

    for i in 0..n {
        print!("{} ", a[i]);

        if i == k - 1 {
            print!("{} ", x);
        }
    }
    
    println!("");
}
