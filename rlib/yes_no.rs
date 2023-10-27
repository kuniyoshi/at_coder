struct YesNo;

impl YesNo {
    pub fn get(is_yes: bool) -> String {
        if is_yes { "Yes".to_string() } else { "No".to_string() }
    }
}

fn main() {
    println!("true -> {}", YesNo::get(true));
    println!("false -> {}", YesNo::get(false));
}