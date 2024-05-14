use std::collections::{HashMap, HashSet, VecDeque};

#[derive(Debug)]
#[derive(Eq, PartialEq)]
#[derive(Hash)]
#[derive(Clone, Copy)]
struct Point {
    i: usize,
    j: usize,
}

impl Point {
    fn moves(self: &Self, h: usize, w: usize) -> Vec<Self> {
        let mut points = Vec::new();

        if self.i > 0 {
            points.push(Point { i: self.i - 1, j: self.j });
        }

        if self.j > 0 {
            points.push(Point { i: self.i, j: self.j - 1 });
        }

        if self.i < h - 1 {
            points.push(Point { i: self.i + 1, j: self.j });
        }

        if self.j < w - 1 {
            points.push(Point { i: self.i, j: self.j + 1 });
        }

        points
    }

    fn from(v: (usize, usize)) -> Self {
        Self { i: v.0, j: v.1 }
    }
}

fn main() {
    proconio::input! {
        h: usize,
        w: usize,
        a: [proconio::marker::Chars; h],
        n: usize,
        m_input: [(usize, usize, usize); n],
    };

    let mut medicines = Vec::new();

    for i in 0..m_input.len() {
        medicines.push((Point { i: m_input[i].0 - 1, j: m_input[i].1 - 1 }, m_input[i].2));
    }

    let t = find('T', &a);

    medicines.push((Point::from(t), 0));

    #[cfg(debug_assertions)]
    eprintln!("{:?}", medicines);

    let mut medicine_index = HashMap::new();

    for i in 0..medicines.len() {
        medicine_index.insert(medicines[i].0, i);
    }

    let mut reaches = vec![vec![false; medicines.len()]; medicines.len()];

    for i in 0..medicines.len() {
        let mut queue = VecDeque::new();
        let medicine = medicines[i];
        let power = medicine.1;
        let mut visited = HashSet::new();

        queue.push_back((medicine.0, 0));

        while let Some((point, k)) = queue.pop_front() {
            if visited.contains(&point) {
                continue;
            }

            if k > power {
                continue;
            }

            if let Some(&index) = medicine_index.get(&point) {
                reaches[i][index] = true;
            }

            for next in &point.moves(h, w) {
                if visited.contains(next) {
                    continue;
                }
                queue.push_back((*next, k + 1));
            }

            visited.insert(point);
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", reaches);

    let s = find('S', &a);

    if let Some(&start_index) = medicine_index.get(&Point::from(s)) {
        let mut queue = VecDeque::new();
        queue.push_back(start_index);
        let mut visited = HashSet::new();

        while let Some(u) = queue.pop_front() {
            if visited.contains(&u) {
                continue;
            }

            visited.insert(u);

            for v in 0..reaches[u].len() {
                if !reaches[u][v] {
                    continue;
                }
                if visited.contains(&v) {
                    continue;
                }
                queue.push_back(v);
            }
        }

        if visited.contains(&(medicines.len() - 1)) {
            println!("Yes");
        } else {
            println!("No");
        }
    } else {
        println!("No");
    }
}

fn find(c: char, a: &Vec<Vec<char>>) -> (usize, usize) {
    for i in 0..a.len() {
        for j in 0..a[i].len() {
            if a[i][j] == c {
                return (i, j);
            }
        }
    }

    unreachable!()
}
