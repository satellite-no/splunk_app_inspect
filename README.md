# Instructions

App

## Installation

docker pull mybeda/splunk_app_inspect:latest

## Usage
```
docker run -v ~/path/to/my_app.tar.gz:/home/splunk_apps/target_app.tar.gz -it mybeda/splunk_app_inspect:latest
```
/path/to/my_app.tar.gz is the full path to the splunk app.

### Example
```
docker run -v ~/path/to/org_all_indexes.tar.gz:/home/splunk_apps/target_app.tar.gz -it mybeda/splunk_app_inspect:latest
```