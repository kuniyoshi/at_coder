struct Direction {
    value: char,
}

impl Direction {
    fn new(value: char) -> Self {
        assert!(vec!['L','R','U','D'].iter().any(|v| v == &value));
        Self { value }
    }

    fn coordinate(self: &Self, i: usize, j: usize) -> Option<(usize, usize)> {
        match self.value {
            'L' => j.checked_sub(1).map(|nj| Some((i, nj))).unwrap_or(None),
            'R' => Some((i, j + 1)),
            'U' => i.checked_sub(1).map(|ni| Some((ni, j))).unwrap_or(None),
            'D' => Some((i + 1, j)),
            _ => unreachable!("{} is not valid value", self.value),
        }
    }
}
