This script takes a JSON file from a twitter data download, representing direct messages,
and creates multiple plain-text files with the contents of those DMs. 
It runs locally and does NOT display the names of people in the convo.
(That would require a lookup from the twitter API). Instead it just outputs the DM logs using ID numbers.
Here's a web tool to look up twitter IDs: https://tweeterid.com/

How to use this: 

FIRST YOU MUST ALTER THE FIRST LINE OF THE INPUT FILE and remove the
following text>>> window.YTD.direct_message.part0 =  
After you do so, the first line of the file will merely be a square and a
curly bracket.

Run this script like so: 
$ perl read_DMs.pl path/to/direct-message-modified.js
