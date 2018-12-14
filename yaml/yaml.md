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

* Block Format: uses hyphen+space to begin a new item in a specified list.

```
--- # sample block format
- whitwalkers
- vikings are great fighters
- The Man Who Wasn't There might have eaten the pizza
```
* Inline Format: delimited with comma and space and the items are enclosed in JSON.

```
--- # Shopping list
[milk, mentos, frooti, juice, pizza]
```
* Folded Text: converts newlines to spaces and removes the leading whitespace.

```
- {name: south Delhi, pin: 110015}
- name: south delhi
  pin: 110013
```


