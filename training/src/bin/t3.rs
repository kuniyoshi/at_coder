fn main() {
    proconio::input! {
        n: usize,
        heights: [usize; n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", heights);

    let mut maxes_lr = vec![0; n];
    let mut maxes_rl = vec![0; n];

    let mut max = 0;

    for i in 0..n {
        let j = n - i - 1;

        max = max.max(heights[j]);
        maxes_lr[j] = max;
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", maxes_lr);

    max = 0;

    for i in 0..n {
        max = max.max(heights[i]);
        maxes_rl[i] = max;
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", maxes_rl);

    let mut total = 0;

    for i in 0..n {
        total += maxes_lr[i].min(maxes_rl[i]) - heights[i];
    }

    println!("{}", total);
}