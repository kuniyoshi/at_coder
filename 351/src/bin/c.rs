fn main() {
    proconio::input! {
        n: usize,
        a: [usize; n],
    };

    let mut v = Vec::new();

    for i in 0..n {
        v.push(a[i]);

        while v.len() >= 2 && v[v.len() - 2] == v[v.len() - 1] {
            let w = v.pop().unwrap();
            v.pop();
            v.push(w + 1);
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", v);

    println!("{}", v.len());
}
