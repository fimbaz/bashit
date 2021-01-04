#[macro_use] extern crate lazy_static;
use regex::{Regex};
use resiter::while_ok::*;
use std::io::{self, BufRead};

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
        if let Some(termline) = process_line(&l) {
            match termline {
                TerminalLine::History(history) => {
                    println!("{:?}",history);
                },
                TerminalLine::Command(command) => {
                    println!("{:?}",command);
                }
            }
        }
    }).unwrap();
    Ok(())
}
