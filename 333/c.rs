use fmt::Debug;
use std::collections::{BinaryHeap, HashSet};
use std::fmt;
use std::io::{self, BufRead};
use std::str;
use std::cmp::Reverse;

// fn is_three_bits(a: usize) -> bool {
//     let mut count: usize = 0;
//     let mut acc = a;

//     while acc > 0 {
//         if acc & 1 > 0 {
//             count += 1;
//         }

//         acc >>= 1;
//     }

//     count <= 3
// }

// fn get_values(a: usize) -> Vec<usize> {
//     let mut indexes: Vec<usize> = Vec::new();
//     let mut current: usize = 0;

//     while (1<<current ) <= a {
//         if (1 <<current) & a > 0 {
//             indexes.push(current);
//         }
//         current += 1;
//     }

//     indexes.iter().map(|i| unit(i/3)).collect()
// }

// fn unit(a: usize) -> usize {
//     let mut result: usize = 1;

//     for _ in 0..a {
//         result = next_unit(result);
//     }

//     result
// }

fn dfs(cursor: (usize, usize, usize), used: &mut HashSet<(usize, usize, usize)>, units: &Vec<usize>, items: &mut BinaryHeap<Reverse<usize>>) {
    let mut v: Vec<usize> = vec![cursor.0, cursor.1, cursor.2];
    v.sort();
    if used.contains(&(v[0], v[1], v[2])) {
        return ();
    }
    used.insert((v[0], v[1], v[2]));

    if cursor.0 < units.len() && cursor.1 < units.len() && cursor.2 < units.len() {
        items.push(Reverse(units[cursor.0]+units[cursor.1]+units[cursor.2]));
        dfs((cursor.0 + 1, cursor.1, cursor.2), used, units, items);
        dfs((cursor.0, cursor.1 + 1, cursor.2), used, units, items);
        dfs((cursor.0, cursor.1, cursor.2 + 1), used, units, items);
    }
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    let mut units: Vec<usize> = Vec::new();
    let mut acc: usize = 1;

    while 1 == 1 {
        units.push(acc);

        acc = next_unit(acc);

        if acc > 111_111_111_111 {
            break;
        }
    }

    let mut items: BinaryHeap<Reverse<usize>> = BinaryHeap::new();
    let mut used: HashSet<(usize, usize, usize)> = HashSet::new();

    dfs((0, 0, 0), &mut used, &units, &mut items);

    for _ in 0..(n-1) {
        let item = items.pop();
        // eprintln!("{:?}", item);
    }

    println!("{}", items.pop().unwrap().0);

    // for i in 0..68719476736 {
    //     if is_three_bits(i) {
    //         continue;
    //     }

    //     let values: Vec<usize> = get_values(i);
    //     items.push(Reverse(values.iter().sum()));
    // }

    // for _ in 0..(n-1) {
    //     items.pop();
    // }

    // println!("{}", items.pop().unwrap().0);

    // let mut buffer: VecDeque<usize> = VecDeque::new();
    // buffer.push_back(1);
    // buffer.push_back(1);
    // buffer.push_back(1);
    // let mut min: usize = 0;

    // for i in 0..n {
    //     min = buffer.iter().take(3).sum();
    //     buffer.pop_front();

    //     if buffer.len() >= 3 {
    //         continue;
    //     }

    //     let last = buffer[buffer.len() - 1];

    //     if i + 1 != n {
    //         buffer.push_back(next_unit(last));
    //         buffer.push_back(next_unit(last));
    //         buffer.push_back(next_unit(last));
    //     }
    // }

    // println!("{}", min);
}

fn next_unit(a: usize) -> usize {
    a * 10 + 1
}
