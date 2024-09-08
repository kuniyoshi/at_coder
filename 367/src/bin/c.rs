fn main() {
    proconio::input! {
        n: usize,
        k: u64,
        r: [u64; n],
    };

    let mut results = Vec::new();
    let mut buffer = Vec::new();
    dfs(&mut results, &mut buffer, n, k, &r);

    for result in &results {
        for digit in result {
            print!("{} ", digit);
        }

        println!("");
    }
}

fn dfs(out: &mut Vec<Vec<u64>>, buffer: &mut Vec<u64>, n: usize, k: u64, r: &Vec<u64>) {
    if buffer.len() == n {
        if buffer.iter().sum::<u64>() % k == 0 {
            out.push(buffer.clone());
        }

        return;
    }

    for i in 1..=r[buffer.len()] {
        buffer.push(i);
        dfs(out, buffer, n, k, r);
        buffer.pop();
    }
}