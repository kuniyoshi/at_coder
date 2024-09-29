fn main() {
    proconio::input! {
        n: usize,
    }; // TODO: 全部まとめてとって、順番を計算する

    let mut a = vec![];

    for i in 0..n {
        proconio::input! {
            b: [u64; i + 1],
        };
        
        a.push(b);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", &a);

    let mut result = 1;

    for j in 1..=n {
        if result >= j {
            result = a[result - 1][j - 1] as usize;
        } else {
            result = a[j - 1][result - 1] as usize;
        }
    }

    println!("{}", result);
}
