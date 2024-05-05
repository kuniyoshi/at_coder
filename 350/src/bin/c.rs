fn main() {
    proconio::input! {
        n: usize,
        a: [usize; n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", a);

    let mut v: Vec<_> = a.iter().map(|v| v - 1).collect();

    let mut indexes = vec![0; n];

    for i in 0..v.len() {
        indexes[v[i]] = i;
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", v);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", indexes);

    let mut swaps = Vec::new();

    for t in 0..n {
        if t != indexes[t] {
            swaps.push((t + 1, indexes[t] + 1));
        }

        let s = v[t];
        v.swap(t, indexes[t]);
        indexes.swap(t, s);
    }

    println!("{}", swaps.len());

    for &(from, to) in &swaps {
        println!("{} {}", from, to);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", v);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", indexes);
}