# Learning BASH

Resources:
- http://mywiki.wooledge.org/BashGuide

More on regex
- http://mywiki.wooledge.org/RegularExpression

```sh
X=aabbc

REGEX='aa[^c]+c$'
if [[ "$X" =~ "$REGEX" ]]; then echo "OK"; else echo "KO"; fi

# This is incorrect because [^c]* matches the empty string 
# and then b matches aa(b)bc and returns OK.
REGEX='aa[^c]*b'
```
