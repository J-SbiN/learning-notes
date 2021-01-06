# YAML Notes

### Features
- Purely descriptive language with no executable commands
- Data Oriented
- Uses key-value pairs
- JSON is a subset of YAML
- Supports several data types
    - scalars (chars, strings, integer and floats)
    - lists
    - associative arrays
    - allows custom data types
        - extensible type declarations (including class types for objects)
- Includes unicode printable characters
- Encodable in UTF-8/16/32
- Case sensitive
- Space indentation for nesting
- C like escape sequencies
- Idented Delimiting increases delimiter colision resilience
- Non-hierarchical data models.....
- 

### Advertencies
The complexity of the standard led to inconsistent implementations and making the language non-portable:
- significant whitespace may be confusing, hard to track, missleading...
- complex and ambiguous specification may cause confusion on some features or defaults
- configuration files can trigger commands execution or load contents without the users realizing it.
- Type autodetection is a source of errors.
    - unquoted Yes and NO are converted to booleans
    - software version numbers might be converted to floats
- truncated files may be interpreted as valid YAML due to the absence of terminators.

The perceived flaws and complexity of YAML has led to the appearance of StrictYAML, which uses a restricted subset of the YAML specification. \
\
\
\
.
# YAML Syntax

### Comments
- '#' --> line comment
- there is no bulk comment

### Line Scalars
- *my string* is an unquoted scalar 
- '*my sting*' is a literal string
- "*my string*" allows special characters to be represented with C-style escape sequences

### Lists
- "-" identifies a list element per line
- "[item1,item2,item3,...]" identifies an in-line list

### Arrays


### Blocks
- "|" preserves newlines
- ">" folds newlines




[] - lists
{} - maps




\
\
\
.
# References
- https://en.wikipedia.org/wiki/YAML
- https://www.tutorialspoint.com/yaml/index.htm
- https://yaml.org/spec/1.2/spec.html