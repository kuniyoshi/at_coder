use std::io::{self, BufRead};
use std::str::FromStr;
use std::fmt::Debug;
use std::cmp;
use std::collections::HashSet;

fn main() {
    let (h, w): (usize, usize) = ReadInput::read_two().unwrap();
    let s = ReadInput::read_strings(h).unwrap();

    let mut union_find = UnionFind::new(h * w + w);

    for a in 0..h {
        for b in 0..w {
            if s[a][b] != '#' {
                continue;
            }

            for c in -1i32..=1 {
                for d in -1i32..=1 {
                    if cmp::max(c.abs(), d.abs()) == 1 {
                        if is_in(a as i32 + c, h) && is_in(b as i32 + d, w) && s[(a as i32 + c) as usize][(b as i32 + d) as usize] == '#' {
                            let id1 = id(a, b, w);
                            let id2 = id(((a as i32) + c) as usize, ((b as i32) + d) as usize, w);
                            union_find.unite(id1, id2);
                        }
                    }
                }
            }
        }
    }

    let mut set: HashSet<usize> = HashSet::new();

    for a in 0..h {
        for b in 0..w {
            if s[a][b] == '#' {
                set.insert(union_find.root(id(a, b, w)));
            }
        }
    }

    println!("{}", set.len());
}

fn id(a: usize, b: usize, w: usize) -> usize {
    a * w + b
}

fn is_in(a: i32, b: usize) -> bool {
    a >= 0 && (a as usize) < b
}

pub struct UnionFind {
    parents: Vec<usize>,
}

impl UnionFind {
    pub fn new(n: usize) -> Self {
        let parents = (0..n).collect::<Vec<usize>>();
        UnionFind { parents }
    }

    pub fn root(&mut self, v: usize) -> usize {
        if self.parents[v] == v {
            v
        } else {
            self.parents[v] = self.root(self.parents[v]);
            self.parents[v]
        }
    }

    pub fn unite(&mut self, u: usize, v: usize) {
        let root_u = self.root(u);
        let root_v = self.root(v);
        if root_u == root_v {
            return;
        }
        
        self.parents[root_u] = root_v;
    }
}


pub struct ReadInput;

impl ReadInput {
    pub fn read_one<T>() -> Result<T, Box<dyn Debug>>
    where
        T: FromStr,
        T::Err: Debug + 'static,
    {
        let mut lines = io::stdin().lock().lines();
        
        if let Some(Ok(line)) = lines.next() {
            return line.parse().map_err(|e| Box::new(e) as Box<dyn Debug>);
        }
        
        Err(Box::new("Failed to read line"))
    }

    pub fn read_two<T, U>() -> Result<(T, U), Box<dyn Debug>>
    where
        T: FromStr,
        T::Err: Debug + 'static,
        U: FromStr,
        U::Err: Debug + 'static,
    {
        let line = Self::read_one::<String>()?;
        let mut parts = line.split_whitespace();
        let a: T = parts.next().ok_or(Box::new("Missing first element") as Box<dyn Debug>)?.parse().map_err(|e| Box::new(e) as Box<dyn Debug>)?;
        let b: U = parts.next().ok_or(Box::new("Missing second element") as Box<dyn Debug>)?.parse().map_err(|e| Box::new(e) as Box<dyn Debug>)?;
        Ok((a, b))
    }

    pub fn read_strings(n: usize) -> io::Result<Vec<Vec<char>>> {
        let mut lines = io::stdin().lock().lines();
        let mut result = Vec::new();

        for _ in 0..n {
            if let Some(Ok(line)) = lines.next() {
                result.push(line.chars().collect());
            }
            else {
                panic!("Could not read line");
            }
        }

        Ok(result)
    }
}