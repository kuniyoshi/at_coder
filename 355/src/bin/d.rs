use std::{cmp::Reverse, collections::BinaryHeap};

fn main() {
    proconio::input! {
        n: usize,
        mut lr: [(usize, usize); n],
    };

    lr.sort();

    #[cfg(debug_assertions)]
    eprintln!("{:?}", lr);

    let mut queue = BinaryHeap::new();
    let mut result = 0;
    for &(l, r) in &lr {
        #[cfg(debug_assertions)]
        eprintln!("### loop");

        #[cfg(debug_assertions)]
        eprintln!("{:?}", queue);

        while queue.len() > 0 && *queue.peek().unwrap() > Reverse(l) {
            queue.pop();
        }

        #[cfg(debug_assertions)]
        eprintln!("{:?}", queue);

        result += queue.len();

        queue.push(Reverse(r));
    }

    println!("{}", result);
}
