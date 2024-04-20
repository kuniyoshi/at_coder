fn main() {
    proconio::input! {
        n: usize,
        k: i32,
        a: [i32; n],
        b: [i32; n],
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", a);
    #[cfg(debug_assertions)]
    eprintln!("{:?}", b);

    let mut dp = vec![vec![false; 2]; n];
    dp[0][0] = true;
    dp[0][1] = true;

    for i in 1..n {
        dp[i][0] = (dp[i - 1][0] && (a[i] - a[i - 1]).abs() <= k)
            || (dp[i - 1][1] && (a[i] - b[i - 1]).abs() <= k);
        dp[i][1] = (dp[i - 1][0] && (b[i] - a[i - 1]).abs() <= k)
            || (dp[i - 1][1] && (b[i] - b[i - 1]).abs() <= k);
    }

    println!(
        "{}",
        if dp.last().unwrap().iter().any(|v| *v) {
            "Yes"
        } else {
            "No"
        }
    );
}
