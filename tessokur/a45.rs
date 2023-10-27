use std::io::{self, BufRead};
use std::str::FromStr;
use std::fmt::Debug;

fn main() {
    let (_, c): (usize, char) = ReadInput::read_two().unwrap();
    let a: Vec<char> = ReadInput::read_one::<String>().unwrap().chars().collect();

    let count = a.iter().fold(std::collections::HashMap::new(), |mut acc, &ch| {
        *acc.entry(ch).or_insert(0) += 1;
        acc
    });

    let mut score = 0;

    for (key, value) in &count {
        if key == &'W' {
            score += 0 * value;
        }
        else if key == &'B' {
            score += 1 * value;
        }
        else if key == &'R' {
            score += 2 * value;
        }
    }

    let color = [('W', 0), ('B', 1), ('R', 2)].iter().cloned().collect::<std::collections::HashMap<char, i32>>();

    println!("{}", YesNo::get(score % 3 == color[&c]));
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

    pub fn read_three<T, U, V>() -> Result<(T, U, V), Box<dyn Debug>>
    where
        T: FromStr,
        T::Err: Debug + 'static,
        U: FromStr,
        U::Err: Debug + 'static,
        V: FromStr,
        V::Err: Debug + 'static,
    {
        let line = Self::read_one::<String>()?;
        let mut parts = line.split_whitespace();
        let a: T = parts.next().ok_or(Box::new("Missing first element") as Box<dyn Debug>)?.parse().map_err(|e| Box::new(e) as Box<dyn Debug>)?;
        let b: U = parts.next().ok_or(Box::new("Missing second element") as Box<dyn Debug>)?.parse().map_err(|e| Box::new(e) as Box<dyn Debug>)?;
        let c: V = parts.next().ok_or(Box::new("Missing third element") as Box<dyn Debug>)?.parse().map_err(|e| Box::new(e) as Box<dyn Debug>)?;
        Ok((a, b, c))
    }

    pub fn read_tuples<T: FromStr>(n: usize) -> Result<Vec<(T, T)>, Box<dyn Debug>>
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
                        if parts.len() == 2 {
                            let b = parts.pop().unwrap();
                            let a = parts.pop().unwrap();
                            result.push((a, b));
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

    pub fn read_values<T>() -> Result<Vec<T>, Box<dyn Debug>>
    where
        T: FromStr,
        T::Err: Debug + 'static,
    {
        let stdin = io::stdin();
        let mut lines = stdin.lock().lines();
        
        if let Some(Ok(line)) = lines.next() {
            let parsed_values: Result<Vec<T>, _> = line.split_whitespace()
                .map(|s| s.parse())
                .collect();

            return match parsed_values {
                Ok(values) => Ok(values),
                Err(e) => Err(Box::new(e)),
            };
        }

        Err(Box::new("Failed to read line from stdin.") as Box<dyn Debug>)
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
}


struct YesNo;

impl YesNo {
    pub fn get(is_yes: bool) -> String {
        if is_yes { "Yes".to_string() } else { "No".to_string() }
    }
}
