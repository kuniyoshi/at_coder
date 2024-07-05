fn main() {
    proconio::input! {
        n: usize,
        m: usize,
        mut a: [u64; n],
        mut b: [u64; m],
    };

    a.sort();
    b.sort();

    let mut p = 0;
    let mut total = 0;

    for i in 0..m {
        while p < n && a[p] < b[i] {
            p += 1;
        }

        if p == n {
            println!("{}", -1);
            return ();
        }

        total += a[p];
        p += 1;
    }

    println!("{}", total);
}

struct TwoPointers {
    one: usize,
    two: usize,
}

impl TwoPointers {
    fn new() -> Self {
        Self { one: 0, two: 0 }
    }
}