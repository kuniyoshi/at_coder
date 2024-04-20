fn main() {
    proconio::input! {
        n: usize,
        k: usize,
        scores: [[usize; 3]; n],
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", scores);

    let mut totals: Vec<_> = scores.iter().map(|v| v.iter().sum::<usize>()).collect();
    totals.sort();
    totals.reverse();

    let border = totals[k - 1];

    // 515, 428, 120 | 1 => Y, Y, N
    for v in &scores {
        let sum = v.iter().sum::<usize>();
        // #[cfg(debug_assertions)]
        // eprintln!("{:?}", sum);

        println!("{}", if sum + 300 >= border { "Yes" } else { "No" });
    }
}