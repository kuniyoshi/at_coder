use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let inputs: Vec<(usize, usize)> = (0..n)
        .map(|_| {
            let list: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            (list[0], list[1] - 1)
        })
        .collect();

    let mut items: Vec<usize> = vec![0; n];
    let mut requires: Vec<usize> = vec![0; n];
    let mut receives: Vec<usize> = Vec::new();

    for i in (0..n).rev() {
        if inputs[i].0 == 2 {
            requires[inputs[i].1] += 1;
        }
        if inputs[i].0 == 1 {
            if items[inputs[i].1] < requires[inputs[i].1] {
                items[inputs[i].1] += 1;
                receives.push(1);
            } else {
                receives.push(0);
            }
        }
    }

    receives.reverse();
    let mut next: usize = 0;
    items = vec![0; n];
    let mut max: usize = 0;
    let mut current: usize = 0;

    for i in 0..n {
        if inputs[i].0 == 2 {
            if items[inputs[i].1] > 0 {
                items[inputs[i].1] -= 1;
                current -= 1;
            } else {
                println!("{}", -1);
                return;
            }
        }
        if inputs[i].0 == 1 {
            if receives[next] > 0 {
                items[inputs[i].1] += 1;
                current += 1;
                max = max.max(current);
            }

            next += 1;
        }
    }

    println!("{}", max);

    for v in receives.iter() {
        print!("{} ", v);
    }

    println!("");
}
