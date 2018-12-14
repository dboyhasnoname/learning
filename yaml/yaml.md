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
    given : Chris
    family : Dumars
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