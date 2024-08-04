fn main() {
    let mut count = 0;
    let mut current = 0;

    while count < 300 {

        if is_palindrome(current) {
            println!("{}", current);
            count += 1;
        }

        current += 1;
    }
}

fn is_palindrome(n: usize) -> bool {
    let s = n.to_string();
    let t = s.chars().rev().collect::<String>();
    t == s
}