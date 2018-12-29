# JSON

JSON is a data-interchange format. This format is based on ECMA-404. For more information, refer to http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf. JSON can be defined as a key-value model. We can write the following script:

```
{
 key: value
}
```

For instance, we can define a JSON object for the Employee data. We can write the following scripts:

```
{
 "id": 1,
 "name": "michael",
 "country": "us"
}
```

We can see that the Employee object has three attributes—id, name, and country. 
Technically, we can declare an attribute in numeric and string types. We can also define a collection of the Employee object using []. 
Each object is defined in {}. We can write the scripts as follows:

```
[
 {
  "id": 1,
  "name": "michael",
  "country": "us"
 },
 {
  "id": 2,
  "name": "jason",
  "country": "uk"
 },
 {
  "id": 3,
  "name": "ryu",
  "country": "jp"
 }
]
```

JSON supports unlimited parent-child attributes. For instance, each Employee object probably has two or more addresses. We can declare them as follows:

```
{
 "id": 1,
 "name": "michael",
 "address":[
      {
        "street": "abc street",
        "city": "new york"
      },
      {
        "street": "vue street",
        "city": "hoston"
      }
 ],
 "country": "us"
}

```

In the JSON format, we use {} and : for key-value data. In YAML, we only use :