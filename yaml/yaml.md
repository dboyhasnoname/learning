# YAML

* YAML Ain’t Markup Language is a data serialization language that matches user’s expectations about data. 
* It designed to be human friendly and works perfectly with other programming languages.
* Supports one-direction processing. 

## Rules for Creating YAML file

* YAML is case sensitive
* The files should have .yaml as the extension
* YAML **does not allow the use of tabs** while creating YAML files; **spaces are allowed instead.**
* Comments in YAML begins with the (#) character and must be separated from other tokens by whitespaces.
* Indentation of whitespace is used to denote structure.
* List members are denoted by a leading hyphen (-) and are enclosed in square brackets and separated by commas.
* Associative arrays are represented using colon ( : )in the format of key value pair.
They are enclosed in curly braces {}.
* Multiple documents with single streams are separated with 3 hyphens (---).
* Repeated nodes in each file are initially denoted by an ampersand (&) and by an asterisk (*) mark later.
* YAML always requires colons and commas used as list separators followed by space with scalar values.
* Nodes should be labelled with an exclamation mark (!) or double exclamation mark (!!), followed by string which can be expanded into an URI or URL.

## Formats of YAML File

* **Block Format:** uses hyphen+space to begin a new item in a specified list.

```
--- # sample block format
- whitwalkers
- vikings are great fighters
- The Man Who Wasn't There might have eaten the pizza
```
* **Inline Format:** delimited with comma and space and the items are enclosed in JSON.

```
--- # Shopping list
[milk, mentos, frooti, juice, pizza]
```
* **Folded Text:** converts newlines to spaces and removes the leading whitespace.

```
- {name: south Delhi, pin: 110015}
- name: south delhi
  pin: 110013
```

## Indentation of YAML

_YAML does not include any mandatory spaces. Further, there is no need to be consistent._ Below yaml is totally valid.

```
a:
  b:
     - south_delhi
     -   crossing_republic
     -  sohna
f:
 "rajeev_chowk"
```

### rules while working with indentation in YAML:

* Flow blocks must be intended with at least some spaces with surrounding current block level.
* Flow content of YAML spans multiple lines. The beginning of flow content begins with { or [.
* Block list items include same indentation as the surrounding block level because "-" is considered as a part of indentation.

_Example of Intended Block_

```
--- !mykirana.com/^invoice
invoice: 108
date : 2051-01-23
bill-to: &id001
    given : Baba 
    family : bottleopenerwala
    address:
        lines: |
            458 Mumbai II.
            Kholi #292
        city : Mumbai
        state : MH
        postal : 48046
ship-to: *id001
product:
    - sku : mug
      quantity : 4
      description : designer_Basketball_print
      price : 2450.10
    - sku : vase
      quantity : 3
      description : Super Hoop
      price : 7392.00
tax : 2951.42
total: 10443.52
comments: >
    Late afternoon is best.
    Backup contact is Baba apte
 ```

## Separation of Strings

* Strings are separated using double-quoted string.
* If we escape the newline characters in a given string, it is completely removed and translated into space value. 

```
errors:
    messages:
        already_confirmed: "was already confirmed, please try signing in"
        confirmation_period_expired: "needs to be confirmed within %{period}, please request a new one"
        expired: "has expired, please request a new one"
        not_found: "not found"
        not_locked: "was not locked"
        not_saved:
            one: "1 error prohibited this %{resource} from being saved:"
            other: "%{count} errors prohibited this %{resource} from being
saved:"
```

Above example refers to the set of error messages which a user can user just by mentioning the key aspect and to the fetch the values accordingly. This pattern of YAML follows the structure of JSON which can be understood by user who is new to YAML.

## YAML – Comments 

* **YAML supports single line comments only.** YAML does not support multi line comments. 

```
 A commented block is skipped during execution.
 Comments help to add description for specified code block.
 Comments must not appear inside scalars.
 YAML does not include any way to escape the hash symbol (#) so within multi-line string so there is no way to divide the comment from the raw string value.
```

## YAML – Collections and Structures 

* YAML includes block collections which use indentation for scope. 
* Here, each entry begins with a new line.
* Block sequences in collections indicate each entry with a dash and space(-).
* In YAML, block collections styles are not denoted by any specific indicator.
* Block collection in YAML can distinguished from other scalar quantities with an identification of
key value pair included in them.
* Mappings are the representation of key value as included in JSON structure.
* It is used often in multi-lingual support systems and creation of API in mobile applications.
* Mappings use key value pair representation with the usage of colon and space (:).

_Examples:_

* example of sequence of scalars, for example a list of ball players 

```
- Mark Mehta
- James Shama
- Ken Gulati
```

* mapping scalars to scalars:

```
hr: 87
avg: 0.298
no_clue: 149
```

* mapping scalars to sequences:

```
Tamil_Nadu:
- Smabhar
- Idli
- Vada
national:
- Khichdi
- Gulab Jamun
- Butter Chicken
```

* Collections can be used for sequence mapping

```
-
name: Mark Mishra
hr: 87
avg: 0.278
-
name: James Pandey
hr: 63
avg: 0.288
```


* With collections, YAML includes flow styles using explicit indicators instead of using indentation to denote space.
* The flow sequence in collections is written as comma separated list enclosed in square brackets.
* The best illustration for collection which is included in PHP frameworks like symphony.

` [Go, PHP, Python] `

* These collections are stored in documents.
* The separation of documents in YAML is denoted with three hyphens or dashes (---). 
* The end of document is marked with three dots (…).

* A question mark with a combination of space indicates a complex mapping in structure.
* Within a block collection, a user can include structure with a dash, colon and question
mark. 

_The following example shows the mapping between sequences:_

```
- 2001-07-23
? [ New Delhi Titans,Mumbai Braves ]
: [ 2001-07-02, 2001-08-12, 2001-08-14]
```

## YAML – Scalars and Tags 

* Scalars in YAML are written in block format using a literal type which is denoted as(|).
* It denotes line breaks count. In YAML, scalars are written in folded style (>) where each line
denotes a folded space which ends with an empty line or more indented line.

The folded newlines are preserved for more indented lines and blank lines as shown below:

```
>
Virat Kohli completed another
fine season with great stats.
1663 Home Runs
93.288 Batting Average
What a year!
```

* YAML flow scalars include plain styles and quoted styles. The double quoted style includes various escape sequences. Flow scalars can include multiple lines; line breaks are always folded in this structure

```
plain:
This unquoted scalar
spans many lines.
quoted: "So does this
quoted scalar.\n"
```

* In YAML, untagged nodes are specified with a specific type of the application. The examples
of tags specification generally use **seq**, **map** and **str** types for YAML tag repository. The
tags are represented as examples which are mentioned as below:

### Integer tags

These tags include integer values in them. They are also called as numeric tags.

```
canonical: 12345
decimal: +12,345
sexagecimal: 3:25:45
octal: 014
hexadecimal: 0xC
```

### Floating point numbers
These tags include decimal and exponential values. They are also called as exponential tags.

```
canonical: 1.23015e+3
exponential: 12.3015e+02
sexagecimal: 20:30.15
fixed: 1,230.15
negative infinity: -.inf
not a number: .NaN
```

### Miscellaneous Tags
It includes a variety of integer, floating and string values embedded in them. Hence it is called miscellaneous tags.

```
null: ~
true: y
false: n
string: '12345
```

## YAML – Full Length Example 

```
defaults: &defaults
 adapter: mongodb
 host: localhost
development:
 database: personal_app_aws
 <<: *defaults
test:
 database: myapp_aws
 <<: *defaults
 ```

The above yaml converted to JSON.

```
{
    "defaults": {
        "adapter": "mongodb",
        "host": "localhost"
    },
    "development": {
        "database": "personal_app_aws",
        "adapter": "postgres",
        "host": "localhost"
    },
    "test": {
        "database": "myapp_aws",
        "adapter": "mongodb",
        "host": "localhost"
    }
}
 ```

 **The defaults key with a prefix of “ <<: *” is included as and when required with no need to write the same code snippet repeatedly.**


## YAML – Processes 

* YAML follows a standard procedure for Process flow. 
* The native data structure in YAML includes simple representations such as nodes. It is also called as Representation Node Graph.
* It includes **mapping**, **sequence** and **scalar** quantities which is being serialized to create a serialization tree.

The processing of YAML information includes three stages: 
1. Representation 
   - sequence
   - mapping
   - scalar 
2. Serialization
3. Presentation 
4. Parsing.

### Representation
> **Sequence**

Sequence refers to the ordered number of entries, which maps the unordered association of key value pair. 

```
product:
    - sku : BL394D
      quantity : 4
      description : Vase
      price : 4450.00
    - sku : BL4438H
      quantity : 1
      description : Super Boot
      price : 12392.00
 ```

 > **Mapping**

represents dictionary data structure or hash table.

```
batchLimit: 1000
threadCountLimit: 2
key: value
keyMapping: <What goes here?>
```

> **Scalars**

represent standard values of strings, integers, dates and atomic data types. Note
that YAML also includes nodes which specify the data type structure. For more information
on scalars, please refer to the chapter 6 of this tutorial.

### Serialization

Serialization process is required in YAML that eases human friendly key order and anchor
names. The result of serialization is a YAML serialization tree. It can be traversed to
produce a series of event calls of YAML data.

```
consumer:
  class: 'AppBundle\Entity\consumer'
  attributes:
    filters: ['customer.search', 'customer.order', 'customer.boolean']
  collectionOperations:
    get:
      method: 'GET'
        normalization_context:
          groups: ['customer_list']
  itemOperations:
    get:
      method: 'GET'
      normalization_context:
        groups: ['customer_get']
 ```

 ### Presentation

* The final output of YAML serialization is called presentation.
* It represents a character stream in a human friendly manner.
* YAML processor includes various presentation details for creating stream, handling indentation and formatting content. 

```
{
    "consumer": {
    "class": "AppBundle\\Entity\\consumer",
    "attributes": {
        "filters": [
            "customer.search",
             "customer.order",
             "customer.boolean"
         ]
    },
    "collectionOperations": {
         "get": {
            "method": "GET",
            "normalization_context": {
                "groups": [
                    "customer_list"
                ]
            }
        }
    },
    "itemOperations": {
        "get": {
            "method": "GET",
            "normalization_context": {
                "groups": [
                    "customer_get"
                 ]
            }
        }
    }
  }
}    
 ```

 ### Parsing

* Parsing is the inverse process of presentation; it includes a stream of characters and
creates a series of events. It discards the details introduced in the presentation process
which causes serialization events.
* Parsing procedure can fail due to ill-formed input.
* It is basically a procedure to check whether YAML is well-formed or not.
* YAML lint is the online parser of YAML and helps in parsing the YAML structure to check
whether it is valid or not. 
* The official link for YAML lint is mentioned below:
http://www.yamllint.com/


## Syntax Characters 

```

_  It denotes a block sequence entry
?  It denotes a mapping key
:  It denotes a mapping value
,  It denotes flow collection entry
[  It starts a flow sequence
]  It ends a flow sequence
{  It starts a flow mapping
}  It ends a flow mapping
#  It denotes the comments
&  It denotes node’s anchor property
*  It denotes alias node
!  It denotes node’s tag
|  It denotes a literal block scalar
>  It denotes a folded block scalar
‘  Single quote surrounds a quoted flow scalar
“  Double quote surrounds double quoted flow scalar
%  It denotes the directive used

```
_example_

```
%YAML 1.1
---
!!map {
? !!str "sequence"
: !!seq [
!!str "one", !!str "two"
],
? !!str "mapping"
: !!map {
? !!str "sky" : !!str "blue",
? !!str "sea" : !!str "green",
}
}
# This represents
# only comments.
---
!!map1 {
? !!str "anchored"
: !local &A1 "value",
? !!str "alias"
: *A1,
}
!!str "text"
```




