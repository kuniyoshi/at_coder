fn main() {
    proconio::input! {
        n: u64,
    };

    let mut keta = 1;
    let mut remain = n;

    loop {
        #[cfg(debug_assertions)]
        eprintln!("{:?}", (remain, count_per_keta(keta)));

        if remain <= count_per_keta(keta + 1) {
            println!("{}", nth());
            break;
        }

        remain -= count_per_keta(keta);
        keta += 1;
    }
}

fn count_per_keta(a: u64) -> u64 {
    match a {
        1 => 10,
        v => 9 * 10_u64.pow(v as u32 / 2),
    }
}
