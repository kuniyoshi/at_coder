fn main() {
    proconio::input! {
        n: usize,
        x: usize,
    }

    let mut l = Vec::new();

    for _ in 0..n {
        proconio::input! {
            k: usize,
            list: [usize; k],
        }
        l.push(list);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", l);

    println!("{}", dfs(x, 0, &l));
}

fn dfs(x: usize, i: usize, l: &Vec<Vec<usize>>) -> usize {
    if i == l.len() {
        return if x == 1 { 1 } else { 0 };
    }

    let mut total = 0;

    for j in 0..l[i].len() {
        if x >= l[i][j] && x % l[i][j] == 0 {
            total += dfs(x / l[i][j], i + 1, l);
        }
    }

    total
}
