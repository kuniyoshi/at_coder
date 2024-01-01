use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, k): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    
    // 11 12 16 22 27 28 31
    // 11, 12
    // 11, 16
    // 12, 16
    // 12, 22
    // 16, 22
    // 

    let mut count: usize = 0;

    for i in 0..(n-1) {
        if a[i] + k >= a[n-1] {
            count += (n - 1) - i;
            continue;
        }

        let mut ac = i;
        let mut wa = n - 1;

        while wa - ac > 1 {
            let wj = (ac + wa) / 2;
            if a[wj] <= a[i] + k {
                ac = wj;
            }
            else {
                wa = wj;
            }
        }

        // println!("{} {} {} {}", i, a[i], ac, a[ac]);
        count += ac - i;
    }

    println!("{}", count);
}