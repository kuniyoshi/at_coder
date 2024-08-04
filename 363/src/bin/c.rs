use std::collections::HashSet;

fn main() {
    proconio::input! {
        _: usize,
        k: usize,
        s: proconio::marker::Chars,
    };

    let indexes: Vec<usize> = (0..s.len()).collect();
    let mut used = HashSet::new();
    let mut total = 0;

    for permutation in permutations(&indexes) {
        let chars: Vec<char> = permutation.iter().map(|i| s[*i]).collect();
        let key = chars.iter().collect::<String>();
        if !used.contains(&key) && test(&chars, k) {
            total += 1;
        }
        used.insert(key);
    }

    println!("{}", total);
}

fn permutations<T: Clone>(arr: &[T]) -> impl Iterator<Item = Vec<T>> {
    struct PermutationIterator<T: Clone> {
        arr: Vec<T>,
        indices: Vec<usize>,
        first: bool,
    }

    impl<T: Clone> Iterator for PermutationIterator<T> {
        type Item = Vec<T>;

        fn next(&mut self) -> Option<Self::Item> {
            if self.first {
                self.first = false;
                return Some(self.arr.clone());
            }

            let n = self.arr.len();
            let mut i = n - 1;

            while i > 0 && self.indices[i - 1] >= self.indices[i] {
                i -= 1;
            }

            if i == 0 {
                return None;
            }

            let mut j = n - 1;
            while self.indices[j] <= self.indices[i - 1] {
                j -= 1;
            }

            self.indices.swap(i - 1, j);
            self.indices[i..].reverse();

            Some(self.indices.iter().map(|&idx| self.arr[idx].clone()).collect())
        }
    }

    PermutationIterator {
        arr: arr.to_vec(),
        indices: (0..arr.len()).collect(),
        first: true,
    }
}

fn is_palindrome(chars: &Vec<char>) -> bool {
    if chars.len() <= 1 {
        return true;
    }
    let len = chars.len();
    for i in 0..len / 2 {
        if chars[i] != chars[len - 1 - i] {
            return false;
        }
    }
    true
}

fn test(chars: &Vec<char>, k: usize) -> bool {
    assert!(k <= chars.len());

    for i in 0..chars.len() {
        if i + k > chars.len() {
            break;
        }

        if is_palindrome(&chars.iter().skip(i).take(k).map(|c| *c).collect()) {
            return false;
        }
    }

    true
}
