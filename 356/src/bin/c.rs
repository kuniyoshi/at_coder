#[derive(Debug)]
struct Test {
    keys: Vec<usize>,
    result: bool,
}

impl Test {
    fn new(keys: &Vec<usize>, result: char) -> Self {
        Self {
            keys: keys.clone(),
            result: result == 'o',
        }
    }
}

fn main() {
    proconio::input! {
        n: usize,
        m: usize,
        k: usize,
    };

    let mut tests = Vec::new();

    for _ in 0..m {
        proconio::input! {
            c: usize,
            keys: [usize; c],
            result: char,
        };
        tests.push(Test::new(&keys, result));
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", tests);

    let mut total = 0;

    for i in 0..(2_u64.pow(n as u32)) {
        total += test(&keys(i, n), k, &tests);
    }

    println!("{}", total);
}

fn test(keys: &Vec<bool>, k: usize, tests: &Vec<Test>) -> u64 {
    for i in 0..tests.len() {
        let mut collects = 0;

        for key in &tests[i].keys {
            if keys[key - 1] {
                collects += 1;
            }
        }

        if (collects >= k) != tests[i].result {
            return 0;
        }
    }

    1
}

fn keys(a: u64, n: usize) -> Vec<bool> {
    let mut result = vec![false; n];

    for i in 0..n {
        result[i] = (a & 1 << i) > 0;
    }

    result
}