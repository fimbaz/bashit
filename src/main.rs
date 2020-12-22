use regex::Regex;
use resiter::while_ok::*;
use std::io::{self, BufRead, Read};

fn main() -> io::Result<()> {
    let re = Regex::new(r"\(\(MBHIST\)\)(.*)\(\(MBHISTEND\)\)").unwrap();
    let stdin = io::stdin(); // We get `Stdin` here.
    for maybe_line in stdin.lock().lines() {
        match maybe_line {
            Ok(line) => match re.captures(&line) {
                Some(capture) => {
                    let history_item = capture.get(1).unwrap().as_str();
                    println!("{}", history_item);
                }
                None => continue,
            },
            Err(_) => return Ok(()),
        }
    }

    Ok(())
}
//	 if let Some(captures) = re.captures(&line){
