trait ClampSubtraction {
    fn clamp_sub(&self, value: usize) -> usize;
}

impl ClampSubtraction for usize {
    fn clamp_sub(&self, value: usize) -> usize {
        if value > *self {
            0
        } else {
            *self - value
        }
    }
}

fn main() {
    println!("{}", 3.clamp_sub(4)); // 4
}
