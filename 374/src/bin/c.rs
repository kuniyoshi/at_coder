fn main() {
    proconio::input! {
        n: usize,
        k: [u64; n],
    };

    let mut min = k.iter().sum::<u64>();

    for i in 0..(2_i32.pow(n as u32) as usize) {
        let a = (0..n).map(|j| if ((1 << j) & i) > 0 { k[j] } else { 0 }).sum::<u64>();
        let b = (0..n).map(|j| if ((1 << j) & i) == 0 { k[j] } else { 0 }).sum::<u64>();

        min = (a.max(b)).min(min);
    }

    println!("{}", min);
}
