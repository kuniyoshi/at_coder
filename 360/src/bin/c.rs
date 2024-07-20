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

    let total = boxes.iter().map(|baggages| {
        let weights: Vec<_> = baggages.iter().map(|i| w[*i]).collect();
        let sum = weights.iter().sum::<u64>();
        let max = weights.iter().max().unwrap_or(&0);
        sum - max
    }).sum::<u64>();

    println!("{}", total);
}
