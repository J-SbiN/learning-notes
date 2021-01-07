# YAML Notes

YAML is a data oriented and purely descriptive language.
Its name is a recursive achronim that stands for Yaml Ain't Markup Language.

For a complete and updated refernce check the [official YAML page](https://yaml.org "https://yaml.org").

I found this [quick cheat sheet](https://gist.github.com/jonschlinkert/5170877) very usefull.

The rest of this document is me writing down to consolidate what I know and for self retrospective looping. 

## Overview/Structure/Glossary
YAML is generally chosen for its flexibility to describe and transmit large, complex and not so structured chunks of information. But its flexibility made it usable for kinds of tasks.

To organize the information 
 
**indicators** - used to denote scope

block colections
block sequencies
mappings
flowstyles


- **stream**
- **document**
- **block**
- **node**
- **colection**
- **list**
- **array**


### Important Notes
- Case sensitive
- Space (not tab) indentation
- Indentation may be used for nesting
- Non-hierarchical data models
- C like escape sequencies

#### Not So Important Notes
- YAML supports one-pass processing
- YAML is a superset of JSON
- StrictYAML uses a restricted subset of YAML 
- Supports several data types and allows custom extensible data types declaration
- Includes unicode printable characters
- Encodable in UTF-8/16/32
- Type autodetection may be a source of errors:
    - unquoted Yes and No are converted to booleans
    - software version numbers might be converted to floats
- truncated files may be interpreted as valid YAML due to the absence of terminators
- configuration files can trigger commands execution or load contents without the users 

## Native Datatypes
- scalars
    - chars/strings
    - integers
    - floats
- booleans (true/false)
- timestamps (date, datetime)
- sequences ( these can be *lists* or *associative arrays*
    - arrays (key-value pairs)
        - dictionarys ()
        - hash-maps ()
    - lists (arrays with omited/undefined/null values)
        - set (unorderer list with no duplicates)
- binary (binary data of octal strings - images,files)
- allows custom extensible data type declarations (ex.: class types for objects)
---
\
\
\
\
.
# YAML Syntax (Cheat Sheet)


## Comments
- ```#``` - *line comments* comment the rest of the line
```
# This is a line with no effect
```
- there is no bulk comment
```
#  Comments with several lines 
# need several '#'s at line start.
```

## Stream Control
- "```---```" - starts a new document within a stream
- "```...```" - ends a document within a stream
```
---  # starts a new document
    key1: value1
...  # ends the current document

---  # stars another document
    keyA: valueA

# notice that the last document isn't closed!
# But that is not an issue.
```
## Key-Value pairs
- "```: ```" - seprates key from value (notice the space!)
- *```key```* comes to the left of "```: ```"
- *```value```* comes to the right of "```: ```"
```
key: value  # the simplest key-value declaration
```
- *```!!type```* - force defines the value to be of the type *type* 
### Quotation
- *my string 1.1.2* - is an unquoted scalar 
- ```'```*my sting 1.1.2*```'``` - is a literal string
- ```"```*my string 1.1.2*```"``` allows special characters to be represented with C-style escape sequences
### Bolleans
- *```true```* stands for the unitary logic value
- *```false```* stands for the absorvent logic value
## Lists
- "-" identifies a list element per line
- "[item1,item2,item3,...]" identifies an in-line list
## Arrays
## Blocks
- ```!!```*```type```* - defines the value of the previous key to be of the type *```type```*
- ```?``` - 
- ```>``` - *folded block styles* disregards indentation and colapses newlines into a space
- ```|``` - *literal style* disregards indentation for nesting but preserves newlines
## Nesting
- nesting can be done in-line or with multiple line bulks
- in-line nesting must use *colection* indicators
- multi-line nesting must respect indentation
- both in-line and multi-line nesting may be used on the same object
### Indentation
- indentation represents nesting
- indentation is in spaces (not tabs)
- 4 spaces represent one indentation level
### In-line Nesting
### Multiline Nesting

[] - lists
{} - maps

---
\
\
\
\
.
# YAML Examples

## Stream Flow

## Key-Value Pairs


## Arrays

## Lists
### Sets
#### Typed sets
##### specifying the ```!!set``` tag and ```?``` symbole makes the set
```
numbers :!! set
? one
? two
? three
```
#### Flow Style Sets
is a json represenation of values using the ```!!set``` tag
```
numbers: !!set { 'one', "two", three }
```

the equavalent of above two set examples as map

numbers:
  one: null
  two: null
  three: null

---
\
\
\
\
.
# References
- https://en.wikipedia.org/wiki/YAML
- https://www.w3schools.io/file/yaml-introduction/
- https://www.tutorialspoint.com/yaml/index.htm
- https://yaml.org/spec/1.2/spec.html
- https://gist.github.com/jonschlinkert/5170877