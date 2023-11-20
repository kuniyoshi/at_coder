use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = read_one(&mut lines);
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    let mut buffers: Vec<usize> = vec![0; 26];
    let mut maxes: Vec<usize> = vec![0; 26];
    let mut previous: Option<char> = None;

    for i in 0..n {
        let index = ((s[i] as u8) - b'a') as usize;

        if previous.map_or(false, |c| c != s[i]) {
            buffers[((previous.unwrap() as u8) - b'a') as usize] = 0;
        }

        buffers[index] += 1;
        maxes[index] = buffers[index].max(maxes[index]);
        previous = Some(s[i]);
    }

    println!("{}", maxes.iter().sum::<usize>());
}

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}
