fn main() {
    proconio::input! {
        n: usize,
        m: usize,
        s: [proconio::marker::Chars; n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (s));

    let t: Vec<_> = s.iter().map(|s_value| flat(s_value)).collect();
    #[cfg(debug_assertions)]
    eprintln!("{:?}", t);

    let last = (0_usize..n).fold(0_u64, |acc, v| acc | t[v]);
    #[cfg(debug_assertions)]
    eprintln!("{:b}", last);
    #[cfg(debug_assertions)]
    eprintln!("{:b}", (1 << m) - 1);


    let mut vertexes = Vec::new();

    println!("{}", dfs(&mut vertexes, &t, m));
}

fn dfs(vertexes: &mut Vec<usize>, t: &Vec<u64>, m: usize) -> usize {
    if vertexes.len() == t.len() {
        unreachable!()
    }

    let mut min = t.len();

    for i in 0..t.len() {
        if vertexes.contains(&i) {
            continue;
        }
        vertexes.push(i);
        if is_complete(vertexes, t, m) {
            min = min.min(vertexes.len());
        } else if vertexes.len() != t.len() {
            min = min.min(dfs(vertexes, t, m));
        } else {
            unreachable!();
        }
        vertexes.pop();
    }

    min
}

fn is_complete(vertexes: &Vec<usize>, t: &Vec<u64>, m: usize) -> bool {
    let types = vertexes.iter().fold(0, |acc, &v| acc | t[v]);
    types == ((1 << m) - 1)
}

fn flat(s: &Vec<char>) -> u64 {
    let mut result = 0;
    for i in 0..s.len() {
        if s[i] == 'o'  {
            result |= 1 << i;
        }
    }
    result
}
