fn main() {
    proconio::input! {
        l: usize,
        r: usize,
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", l);
    #[cfg(debug_assertions)]
    eprintln!("{:?}", r);

    let l_one = 64 - l.leading_zeros() - 1;
    let r_one = 64 - r.leading_zeros() - 1;

    // for i in 
}
