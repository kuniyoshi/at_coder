use std::io::{self, BufRead};
use std::str::FromStr;
use std::fmt::Debug;

fn main() {
    let n = ReadInput::read_one().unwrap();
    let a: Vec<Vec<usize>> = ReadInput::read_matrix(n, n).unwrap();
    let q = ReadInput::read_one().unwrap();
    let queries: Vec<(usize, usize, usize)> = ReadInput::read_triples(q).unwrap();

    let mut row_indexes: Vec<usize> = (0..n).collect();
    
    for &(op, x, y) in &queries {
        if op == 1 {
            row_indexes.swap(x - 1, y - 1);
        }
        else if op == 2 {
            println!("{}", a[row_indexes[x - 1]][y - 1]);
        }
    }
}

pub struct ReadInput;

impl ReadInput {
    pub fn read_matrix<T: FromStr>(h: usize, w: usize) -> Result<Vec<Vec<T>>, Box<dyn Debug>>
    where T::Err: Debug + 'static,
    {
        let stdin = io::stdin();
        let mut lines = stdin.lock().lines();
        let mut matrix = Vec::new();

        for _ in 0..h {
            if let Some(Ok(line)) = lines.next() {
                let row: Result<Vec<T>, _> = line.split_whitespace().map(|s| s.parse()).collect();
                match row {
                    Ok(row) => {
                        if row.len() == w {
                            matrix.push(row);
                        } else {
                            return Err(Box::new("Row length does not match width") as Box<dyn Debug>);
                        }
                    },
                    Err(e) => return Err(Box::new(e) as Box<dyn Debug>),
                }
            } else {
                return Err(Box::new("Failed to read line") as Box<dyn Debug>);
            }
        }

        Ok(matrix)
    }

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

    pub fn read_triples<T: FromStr>(n: usize) -> Result<Vec<(T, T, T)>, Box<dyn Debug>>
    where T::Err: Debug + 'static,
    {
        let stdin = io::stdin();
        let mut lines = stdin.lock().lines();
        let mut result = Vec::new();
    
        for i in 0..n {
            if let Some(Ok(line)) = lines.next() {
                let parts: Result<Vec<T>, _> = line.split_whitespace().map(|s| s.parse()).collect();
                
                match parts {
                    Ok(mut parts) => {
                        if parts.len() == 3 {
                            let c = parts.pop().unwrap();
                            let b = parts.pop().unwrap();
                            let a = parts.pop().unwrap();
                            result.push((a, b, c));
                        } else {
                            return Err(Box::new(format!("Error: Line {} does not contain exactly two elements.", i + 1)) as Box<dyn Debug>);
                        }
                    },
                    Err(e) => return Err(Box::new(e)),
                }
            } else {
                return Err(Box::new("Failed to read line from stdin.") as Box<dyn Debug>);
            }
        }
    
        Ok(result)
    }
}