use std::collections::VecDeque;

fn main() {
    proconio::input! {
        n: usize,
        k: usize,
        a: [usize; n],
    };

    let mut queue = VecDeque::new();

    for &v in &a {
        queue.push_back(v);
    }

    let mut count = 0;
    let mut waitings = 0;

    while let Some(size) = queue.pop_front() {
        if waitings + size > k {
            count += 1;
            waitings = 0;
        }

        waitings += size;
    }

    count += if waitings > 0 { 1 } else { 0 };

    println!("{}", count);
}
