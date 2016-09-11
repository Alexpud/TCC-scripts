## Synopsis

It contains a few scripts and configuration files for usage of openresty on our graduation thesis.Our thesis consists on the usage of several eclipse che web IDE instances behind a nginx proxy server, with nginx redirecting each user to his own instance.

## Motivation

As our motivation was the fact that the lab in our university didn't provide, most of the time, the tools that students required to study subjects or programming languages which weren't seen in the course such as Ruby, Android. 

This and other factors like the lack of power of installing the tools required to study those subjects, the problems that students faced in bringing their own laptops and the fact that some students could not affor laptops.

## Installation

For running openresty and the project itself you will need before anything, docker installed on your machine. For convenience we suggest using linux since docker is native to them unless you are using windows server 2016, windows 10 or higher.

* Docker
* Openresty

#### Openresty

Openresty instalation is pretty straightforward as their github and website show.
What we changed in executing it was the configuration files path, as shown in the bellow code that shows the command to run the configuration
```

./configure --conf-path=/usr/local/openresty/nginx/conf/nginx.conf ....

```

## API Reference

Depending on the size of the project, if it is small and simple enough the reference docs can be added to the README. For medium size to larger projects it is important to at least provide a link to where the API reference docs live.

## Tests

Describe and show how to run the tests with code examples.

## Contributors

Let people know how they can dive into the project, include important links to things like issue trackers, irc, twitter accounts if applicable.

## License

A short snippet describing the license (MIT, Apache, etc.)
