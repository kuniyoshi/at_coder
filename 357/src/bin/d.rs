fn main() {
    proconio::input! {
        n: usize,
    };

    let unit = 998244353;

    let mut result = 0;

    for i in 0..64 {
        if (n & (1 << i)) > 0 {
            result += f(result, i, n);
            result %= unit;
        }
    }

    println!("{}", result);
}

fn f(current: usize, i: usize, n: usize) -> usize {
    let unit = 998244353;
    let mut result = current * (10_u64.pow(current.to_string().len() as u32) as usize) % unit;
     + current f(i - 1, n)
}