struct RollingHash {
    string: String;
    hash: mut Vec<i32>;
    b: i32;
    m: i32;
}

impl RollingHash {
    fn make_hash() {
        let mut bases: Vec<i32> = Vec::new();

        bases.push(1);

        for i in 0..self.string.len() - 1 {
            bases.push(bases[bases.len() - 1] * self.b);
        }


    }
}