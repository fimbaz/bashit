#[macro_use] extern crate lazy_static;
use regex::{Regex,RegexSet};
use resiter::while_ok::*;
use std::io::{self, BufRead, Read};

#[derive(Debug)]
struct History {
    raw: String,
    matched: String
}

#[derive(Debug)]
struct Command {
    raw: String,
    matched: String
}

#[derive(Debug)]
enum TerminalLine {
    History(History),
    Command(Command)
}

fn process_line(line: &str) -> Option<TerminalLine> {
    lazy_static! {
        static ref REHIST: Regex  = Regex::new(r"\(\(MBHIST\)\)(.*)\(\(MBHISTEND\)\)").unwrap();
        static ref RECMD: Regex  = Regex::new(r"\(\(MBCMD\)\)(.*)\(\(MBCMDEND\)\)").unwrap();
    }
    if let Some(caps) = REHIST.captures(line){
        return Some( TerminalLine::History(History {raw: line.to_string(), matched: caps.get(1).unwrap().as_str().to_string() }))
    }
    if let Some(caps) = RECMD.captures(line){
        return Some( TerminalLine::Command(Command {raw: line.to_string(), matched: caps.get(1).unwrap().as_str().to_string() }))
    }
    None
}
fn main() -> io::Result<()> {
    let stdin = io::stdin();
    let lines = stdin.lock().lines();
    lines.while_ok(|l|{
        println!("{:?}",process_line(&l));
    });;
    Ok(())
}
