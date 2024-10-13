fn main() {
    proconio::input! {
        n: usize,
        h: [u64; n],
    };

    for i in 0..n {
        let mut count = 0;

        for j in (i + 1)..n {
            let mut yes = true;

            for k in (i + 1)..j {
                if h[k] > h[j] {
                    yes = false;
                }
            }

            if yes {
                count += 1;
            }
        }

        println!("{}", count);
    }
}
