fn main() {
    proconio::input! {
        n: usize,
        spans: [(i64, i64); n],
    };

    let mut candidates: Vec<_> = spans.iter().map(|(l, _)| *l).collect();
    let sum = candidates.iter().sum::<i64>();

    if sum > 0 {
        println!("No");
        return;
    }

    let mut remain = -sum;

    for i in 0..n {
        let size = remain.min(spans[i].1 - spans[i].0);
        candidates[i] = candidates[i] + size;
        remain -= size;

        if candidates[i] > spans[i].1 {
            panic!("goes to large");
        }

        if remain < 0 {
            panic!("not happen");
        }
    }

    if remain > 0 {
        println!("No");
        return;
    }

    println!("Yes");

    for i in 0..n {
        print!("{} ", candidates[i]);
    }

    println!("");
}
