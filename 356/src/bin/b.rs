fn main() {
    proconio::input! {
        n: usize,
        m: usize,
        a: [u64; m],
        x: [[u64; m]; n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", a);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", x);

    let mut nutrients = vec![0; m];

    for i in 0..n {
        for j in 0..m {
            nutrients[j] += x[i][j];
        }
    }

    for i in 0..m {
        if nutrients[i] < a[i] {
            println!("No");
            return ();
        }
    }

    println!("Yes");
}
