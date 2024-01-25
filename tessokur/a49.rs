use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let t: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let pqr: Vec<(usize, usize, usize)> = (0..t).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0] - 1, list[1] - 1, list[2] - 1)
    }).collect();

    #[cfg(debug_assertions)]
    eprintln!("{:?}", pqr);

    let mut counts: Vec<Vec<usize>> = vec![Vec::new(); 20];

    for i in 0..t {
        counts[pqr[i].0].push(i);
        counts[pqr[i].1].push(i);
        counts[pqr[i].2].push(i);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", counts);

    // 0: A
    // 1: B
    let mut operations: Vec<Option<usize>> = vec![None; t];

    for i in 0..counts.len() {
        if counts[i].len() % 2 == 1 {
            continue;
        }

        let mut none_count: usize = 0;
        let mut a_count: usize = 0;
        let mut b_count: usize = 0;

        for j in &counts[i] {
            match operations[*j] {
                None => none_count += 1,
                Some(0) => a_count += 1,
                Some(1) => b_count += 1,
                _ => panic!("Invalid value"),
            }
        }

        let half = counts[i].len() / 2;

        if a_count > half {
            continue;
        }
        
        let to_a_count = half - a_count;

        if to_a_count > none_count {
            continue;
        }

        let to_b_count = none_count - to_a_count;

        for j in 0..counts[i].len() {
            if operations[counts[i][j]] == None {
                operations[counts[i][j]] = Some(0);
            }

            if to_a_count == 0 {
                break;
            }
        }

        for j in 0..counts[i].len() {
            if operations[counts[i][j]] == None {
                operations[counts[i][j]] = Some(1);
            }

            if to_b_count == 0 {
                break;
            }
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", operations);

    for operation in &operations {
        match *operation {
            Some(0) => println!("A"),
            Some(1) => println!("B"),
            None => println!("A"),
            _ => panic!("invalid value"),
        }
    }
}