fn main() {
    proconio::input! {
        n: usize,
        a: [u64; n],
    };

    let max = a.iter().max().unwrap();
    let remain = a.iter().sum::<u64>() - max;

    if max > &remain {
        println!("{}", remain);
    } else {
        println!("{}", (max + remain) / 2);
    }
}