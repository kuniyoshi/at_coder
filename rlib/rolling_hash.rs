struct RollingHash {
    chars: Vec<char>,
    hashes: Vec<i64>,
    b: i64,
    m: i64,
    bases: Vec<i64>,
}

impl RollingHash {
    pub fn new(chars: Vec<char>, b: i64, m: i64) -> Self {
        let mut rh = Self {
            chars,
            hashes: Vec::new(),
            33,
            1_000_000_007,
            bases: Vec::new(),
        };
        rh.make_hash();
        rh
    }

    fn make_hash(&mut self) {
        let mut bases: Vec<i64> = vec!(1; self.chars.len());
        let mut hashes: Vec<i64> = vec!(0; self.chars.len());

        for i in 0..self.chars.len() {
            bases[i] = if i == 0 { 1 } else { bases[i - 1 ] * self.b };
            bases[i] %= self.m;
            hashes[i] = if i == 0 { self.chars[i] as i64 * bases[i] } else { hashes[i - 1] + self.chars[i] as i64 * bases[i] };
            hashes[i] %= self.m;
        }

        self.bases = bases;
        self.hashes = hashes;
    }

    pub fn dump(&self) {
        eprintln!("{:?}", self.hashes);
    }

    pub fn contains(&self, other: &RollingHash) -> bool {
        let len_s = self.chars.len();
        let len_t = other.chars.len();

        if len_s < len_t {
            return false;
        }

        let mut target_hash = other.hashes[len_t - 1];

        for i in 0..=(len_s - len_t) {
            let mut cur_hash = self.hashes[i + len_t - 1];
            if i > 0 {
                cur_hash -= self.hashes[i - 1];
            }

            // ハッシュ値がオーバーフローした場合の調整
            if cur_hash < 0 {
                cur_hash += self.m;
            }

            // 同じ位置のハッシュ値を正確に比較するために調整
            let adjusted_hash = (target_hash * self.bases[i]) % self.m;

            if cur_hash == adjusted_hash {
                return true;
            }
        }

        false
    }
}

fn main() {
    let long = RollingHash::new("asdffdsaasdfdsa".chars().collect());
    let short = RollingHash::new("ffx".chars().collect());

   println!("{}", long.contains(&short));
}