fn main() {
    proconio::input! {
        n: usize,
        queries: [(i64, char); n],
    };

    let left = queries
        .iter()
        .filter(|(_, hand)| hand == &'L')
        .map(|(position, _)| position)
        .collect::<Vec<_>>()
        .windows(2)
        .map(|l| (l[0] - l[1]).abs())
        .sum::<i64>();

    let right = queries
        .iter()
        .filter(|(_, hand)| hand == &'R')
        .map(|(position, _)| position)
        .collect::<Vec<_>>()
        .windows(2)
        .map(|l| (l[0] - l[1]).abs())
        .sum::<i64>();

    println!("{}", left + right);
}
