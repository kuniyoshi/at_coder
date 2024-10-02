use std::collections::HashMap;

fn main() {
    proconio::input! {
        n: usize,
        mut a: [i64; n],
    };

    let mut l = 0;
    let mut total = n as u64;
    let mut memo = HashMap::new();

    while l < n - 1 {
        let diff = a[l + 1] - a[l];
        let r = ((l + 1)..n)
            .take_while(|&i| a[i] - a[i - 1] == diff)
            .last()
            .unwrap_or(l);

        let addition = addition(&mut memo, r - l);

        total += addition;

        #[cfg(debug_assertions)]
        eprintln!("{:?}", (l, r, diff, addition, total));

        l = r;
    }

    println!("{}", total);
}

fn addition(memo: &mut HashMap<usize, u64>, size: usize) -> u64 {
    if size == 0 {
        return 0;
    }

    if let Some(cache) = memo.get(&size) {
        return *cache;
    }

    let result = size as u64 + addition(memo, size - 1);
    memo.insert(size, result);

    result
    // 差が
    //   1 -> 1
    //   2 -> 3
    //   3 -> 6
}
