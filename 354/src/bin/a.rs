fn main() {
    proconio::input! {
        h: usize,
    };

    for i in 0..35 {
        let plant = (2_u64.pow(i + 1) - 1) as usize;
        #[cfg(debug_assertions)]
        eprintln!("{:?}", plant);

        if plant > h {
            println!("{}", i + 1);
            return ();
        }
    }
}
