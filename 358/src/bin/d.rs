use std::{cmp::Reverse, collections::BinaryHeap};

fn main() {
    proconio::input! {
        n: usize,
        m: usize,
        a: [u64; n],
        mut b: [u64; m],
    };

    b.sort_by(|x, y| y.cmp(x));

    #[cfg(debug_assertions)]
    eprintln!("{:?}", b);

    let mut big_queue = BinaryHeap::new();
    let mut small_queue = BinaryHeap::new();

    for value in &a {
        small_queue.push(value);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", big_queue);

    #[cfg(debug_assertions)]
    eprintln!("{:?}", small_queue);

    let mut cost = 0;

    for value in &b {
        #[cfg(debug_assertions)]
        eprintln!("value: {:?}", value);

        while small_queue.len() > 0 {
            match small_queue.peek() {
                Some(&small) if small >= value => {
                    big_queue.push(Reverse(small));
                    small_queue.pop();
                },
                _ => break,
            };
        }

        #[cfg(debug_assertions)]
        eprintln!("# {:?}", big_queue);

        #[cfg(debug_assertions)]
        eprintln!("# {:?}", small_queue);

        match big_queue.peek() {
            Some(&Reverse(big)) if big >= value => {
                cost += big;
                big_queue.pop();
            },
            _ => {
                println!("{}", -1);
                return ();
            }
        };
    }

    println!("{}", cost);
}
