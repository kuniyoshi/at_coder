fn main() {
    proconio::input! {
        n: usize,
        x: u64,
        y: u64,
        mut a: [u64; n],
        mut b: [u64; n],
    };

    a.sort();
    a.reverse();
    b.sort();
    b.reverse();

    println!("{}", min_eating(a, x).min(min_eating(b, y)));
}

fn min_eating(values: Vec<u64>, max: u64) -> u64 {
    let mut acc = 0;
    let mut min = values.len() as u64;

    for i in 0..values.len() {
        acc += values[i];

        if acc > max {
            min = (i + 1) as u64;
            break;
        }
    }

    min
}