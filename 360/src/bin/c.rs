fn main() {
    proconio::input! {
        n: usize,
        a: [usize; n],
        w: [u64; n],
    };

    let mut boxes = vec![vec![]; n];

    for i in 0..n {
        boxes[a[i] - 1].push(i);
    }

    let mut total = 0;

    for i in 0..n {
        if boxes[i].len() <= 1 {
            continue;
        }

        let mut weights: Vec<_> = boxes[i].iter().map(|j| w[*j]).collect();
        weights.sort();
        let sum = weights.iter().sum::<u64>();
        let max = weights.iter().last().unwrap_or(&0);

        total += sum - max;
    }

    println!("{}", total);
}
