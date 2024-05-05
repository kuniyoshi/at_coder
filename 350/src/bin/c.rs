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

    // v: C A B
    // i: 1 2 0
    for target in 0..n {
        // C と A とを swap したい
        // C は index: target にある
        // A は index: indexes[v[target]] にある

        let ti = indexes[v[target]];
        let vt = v[target];
        v.swap(target, indexes[ti]);

        // 添え字を更新したい
        // 1 2 0 を 0 2 1 にしたい
        // indexes[target] と indexes[v[target]] とを交換したい (置き換わってるのに注意)
        // index == target のところと target とを交換したい
        // indexes[v[target]]
        indexes.swap(target, vt);

        if vt != target {
            swaps.push((target + 1, vt + 1));
        }
    }

    println!("{}", swaps.len());

    for &(from, to) in &swaps {
        println!("{} {}", from, to);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", v);
}
