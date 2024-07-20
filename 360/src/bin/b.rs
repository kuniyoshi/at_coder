fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
        t: String,
    };

    for w in 1..s.len() {
        let mut vrs = vec![vec![]; w];

        for i in 0..s.len() {
            vrs[i % w].push(s[i]);
        }

        if vrs.iter().any(|vr| vr.iter().collect::<String>().eq(&t)) {
            #[cfg(debug_assertions)]
            eprintln!("{:?}", vrs);

            println!("Yes");
            return ();
        }
    }

    println!("No");
}