fn main() {
    proconio::input! {
        s: proconio::marker::Chars,
        t: String,
    };

    if t.len() == 1 {
        println!("No");
        return ();
    }

    for w in 1..(s.len() - 1) {
        let mut vrs = vec![Vec::new(); w];

        for i in 0..s.len() {
            vrs[i % w].push(s[i]);
        }

        if vrs.iter().any(|vr| vr.iter().collect::<String>().contains(&t)) {

        // #[cfg(debug_assertions)]
        // eprintln!("{:?}", vrs);

            println!("Yes");
            return ();
        }
    }

    println!("No");
}