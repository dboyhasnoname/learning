# Fluentd

* Fluentd is a fully free and fully open-source data collector, which lets us unify the data collection and consumption for a better use and understanding of data.
* Fluentd treats logs as JSON, a popular machine-readable format. 
* It is written primarily in C with a thin-Ruby wrapper that gives users flexibility.

![fluentd arch](img/fluentd-architecture.png)

## Use Cases
- Data Search like Splunk
- Data Filtering and Alerting
- Data Analytics with Treasure Data
- Data Collection to MongoDB
- Data Collection to HDFS
- Data Archiving to Amazon S3
- Windows Event Collection

## Advantages

### 1. Unified Logging with JSON

![json logging](img/log-as-json.png)

* Fluentd tries to structure data as JSON as much as possible: this allows Fluentd to unify all facets of processing log data: collecting, filtering, buffering, and outputting logs across multiple sources and destinations (Unified Logging Layer). 
* The downstream data processing is much easier with JSON, since it has enough structure to be accessible while retaining flexible schemas.

### 2.Pluggable Architecture

![plug](img/pluggable.png)

* Fluentd has a flexible plugin system that allows the community to extend its functionality. 
* 500+ community-contributed plugins connect dozens of data sources and data outputs. By leveraging the plugins, we can start making better use of our logs right away.

## The Life of a Fluentd Event

![life_1](img/life_1.jpeg)

<br>

![life_2](img/life_2.jpeg)

<br>

![life_3](img/life_3.jpeg)

<br>

![life_4](img/life_4.jpeg)

<br>

* The configuration file allows the user to control the input and output behavior of Fluentd by 
    - selecting input and output plugins and 
    - specifying the plugin parameters. The file is required for Fluentd to operate properly.



## Config file

### Config File Location

* /etc/fluent/fluent.conf if installed using ruby gems.

### FLUENT_CONF environment variable
We can change default configuration file location via FLUENT_CONF. 

* _Fluentd assumes configuration file is UTF-8 or ASCII._

### List of Directives

The configuration file consists of the following directives:

1. **source** directives determine the input sources.
2. **match** directives determine the output destinations.
3. **filter** directives determine the event processing pipelines.
4. **system** directives set system wide configuration.
5. **label** directives group the output and filter for internal routing
6. **include** directives include other files.

