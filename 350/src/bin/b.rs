fn main() {
    proconio::input! {
        n: usize,
        q: usize,
        t: [usize; q],
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", t);

    let mut teeth = vec![1; n];

    for treatment in &t {
        teeth[*treatment - 1] ^= 1;
    }

    println!("{}", teeth.iter().sum::<usize>());
}
