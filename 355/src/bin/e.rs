fn main() {
    for i in 0_u64..5 {
        for j in 0_u64..5 {
            eprint!("{:?} ", lr((i, j)));
        }
        eprintln!();
    }
}

fn lr((i, j): (u64, u64)) -> (u64, u64) {
    (2u64.pow(i as u32) * j, (2u64.pow(i as u32)) * (j + 1) - 1)
}
