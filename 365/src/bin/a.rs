fn main() {
    proconio::input! {
        y: u64,
    };

    println!("{}", leap_year(y));
}

fn leap_year(y: u64) -> u64 {
    if y % 4 != 0 {
        return 365;
    }
    if y % 4 == 0 && y % 100 != 0 {
        return 366;
    }
    if y % 100 == 0 && y % 400 != 0 {
        return 365;
    }
    if y % 400 == 0 {
        return 366;
    }

    unreachable!();
}
