fn main() {
    proconio::input! {
        n: usize,
        t: usize,
        a: [usize; t],
    };

    let mut rows = vec![0; n];
    let mut cols = vec![0; n];
    let mut slash = 0;
    let mut back_slash = 0;

    for turn in 0..t {
        let (i, j) = coord(a[turn], n);
        rows[i] += 1;
        cols[j] += 1;
        if is_slash((i, j)) {
            slash += 1;
        }
        if is_back_slash((i, j), n) {
            back_slash += 1;
        }

        if rows[i] == n || cols[j] == n || slash == n || back_slash == n {
            println!("{}", turn + 1);
            return ();
        }
    }

    println!("{}", -1);
}

fn is_back_slash((i, j): (usize, usize), n: usize) -> bool {
    is_slash((i, n - j - 1))
}

fn is_slash((i, j): (usize, usize)) -> bool {
    i == j
}

fn coord(value: usize, n: usize) -> (usize, usize) {
    let i = (value - 1) / n;
    let j = (value - 1) % n;
    (i, j)
}