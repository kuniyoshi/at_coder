use std::io::{self, BufRead};
use std::str::FromStr;
use std::fmt::Debug;

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
}

fn main() {
    println!("read strings x 3");
    let s = ReadInput::read_strings(3).unwrap();
    for chars in &s {
        println!("{}", chars.iter().collect::<String>());
    }

    println!("read Vec<(usize, usize>) x 3");
    let e: Vec<(usize, usize)> = ReadInput::read_tuples(3).unwrap();
    for &(e1, e2) in &e {
        println!("({}, {})", e1, e2);
    }

    println!("read Vec<usize>");
    let d: Vec<usize> = ReadInput::read_values().unwrap();
    println!("{}", d.iter().map(|&x| x.to_string()).collect::<Vec<String>>().join(", "));

    println!("read (usize, usize, usize)");
    let (c1, c2, c3): (usize, usize, usize) = ReadInput::read_three().unwrap();
    println!("({}, {}, {})", c1, c2, c3);

    println!("read usize");
    let a: usize = ReadInput::read_one().unwrap();
    println!("{}", a);

    println!("read (usize, usize)");
    let (b1, b2): (usize, usize) = ReadInput::read_two().unwrap();
    println!("({}, {})", b1, b2);
}