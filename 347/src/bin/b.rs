use std::{
    collections::HashSet,
    io::{self, BufRead},
};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    let mut set = HashSet::new();

    for i in 0..s.len() {
        for j in i..s.len() {
            let substr: String = s[i..=j].to_vec().iter().collect();
            set.insert(substr);
        }
    }

    println!("{}", set.len());
}
