fn main() {
    proconio::input! {
        n: usize,
        x: usize,
    }

    let mut l = Vec::new();

    for _ in 0..n {
        proconio::input! {
            k: usize,
            list: [usize; k],
        }
        l.push(list);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", l);
}
