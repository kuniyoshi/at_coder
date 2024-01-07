use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    for i in 0..=n {
        for j in 0..=n {
            if i + j > n {
                break;
            }

            for k in 0..=n {
                if i + j + k > n {
                    break;
                }

                if i + j + k <= n {
                    println!("{} {} {}", i, j, k);
                }
            }
        }
    }
}