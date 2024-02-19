
# TTSclip

**Pre-release 0.x. Let me know if you have any problems! :)**

TTSclip is designed to convert text into speech using AWS Polly. It supports reading text from the clipboard or a specified input argument. Additionally, the script offers options for verbosity, skipping replacing line breaks with spaces, and adjusting the speech tempo. It's composed of a fairly simple bash script, with some quality-of-life options.

Contributions welcome!

## Motivation

I'm a PhD research student with dyslexia, therefore I have a hard time keeping up with all the reading I need to do. Lucky text-to-speech software has made this possible. While there are other tts options available, I have not found one that integrates well enough into my workflow. The ability to read the clipboard using a hotkey, taking advantage of Amazons Polly natural tts, and having the option to adjust tempo has made this the perfect tool for me.

## How to use

```
ttsclip [options] [text]
```

**Options**
- -c: Use text from the clipboard.
- -b: Replaces line breaks with spaces in the input.
- -v: Verbose mode. Output additional information during script execution.
- -t <tempo>: Adjust the tempo of the speech. The default is 1. Accepts numeric values (e.g., 1.5).

The -b flag is used in cases where when copying text from a pdf, each new line is interpreted as line breaks. It's a common issue I ran into and this option can be very handy.

## Installation
#### General
1. Clone repository
1. Ensure all prerequisites are met.
1. Place the script in a desired directory.
1. Run using ./ttsclip.sh or create alias


#### For apt-based systems
```
git clone https://github.com/connbrack/ttsclip.git
cd ttsclip
make
sudo apt install ./ttsclip.deb
```

This code relies on aws Amazon Polly and will not work without it. To get this you will need to set up an aws account and get the cli. Following the steps here (https://docs.aws.amazon.com/polly/latest/dg/getting-started-cli.html)

Please note: The Amazon Polly free tier has a word limit. Exceeding that will start to cost money. For my uses the limit and rates have been reasonable.

## Combining with hotkeys
This tool is most convenient when combined with hotkeys, such as xbindkeys. Here is an example config.

```
## Read clipboard contents
"ttsclip -ct 1.5"
Alt+R

## Kill play task to stop reading
"pkill play"
Alt+T

```

## Future work

1. Offer integration with other tts services
1. Offline fallback tts when internet is not available
