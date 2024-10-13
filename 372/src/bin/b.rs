fn main() {
    proconio::input! {
        mut m: u64,
    };

    let mut a = Vec::new();

    while m > 0 {
        // #[cfg(debug_assertions)]
        // eprintln!("{:?}", ("m", m));

        for i in (0_u64..=10).rev() {
            // #[cfg(debug_assertions)]
            // eprintln!("{:?}", ("i", i));

            let value = 3_i64.pow(i as u32) as u64;

            if m % value == 0 {
                m -= value;
                a.push(i);
                break;
            }
        }
    }

    assert!(a.len() <= 20);
    println!("{}", a.len());

    for v in &a {
        print!("{} ", v);
    }

    println!("");
}
