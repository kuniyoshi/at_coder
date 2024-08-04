fn main() {
    proconio::input! {
        r: u64,
    };

    match r {
        1..=99 => println!("{}", 100 - r), // TODO: なんで閉区間じゃないとダメ?
        100..=199 => println!("{}", 200 - r),
        200..=299 => println!("{}", 300 - r),
        300..=399 => println!("{}", 400 - r),
        _ => unreachable!(),
    };
}
