---
title: "URI vs URL in Java"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/10/16/java-uri-vs-url.html
category: java
related: java
#image: /assets/images/kapresoft1-210x.png
description: "Guide to understanding the distinction between URL and URI in the Java programming language, including practical examples."
---

## Overview

In the realm of Java and web development, the terms URL and URI often emerge in discussions, leaving some in a quagmire of confusion. This article aims to elucidate the disparities between the two, elucidating their syntax, utilization in Java, and the nuances that set them apart.<!--excerpt-->

## Deciphering the Contrast: URL vs URI

The differentiation between a Uniform Resource Identifier (URI) and a Uniform Resource Locator (URL) is pivotal in understanding web-based resources.

### Uniform Resource Identifier (URI)
A URI is a character sequence that uniquely defines an abstract or physical resource. Essentially, it's a method of identifying any resource on the internet, whether it's a page of text, a video, an image, or a downloadable file.

### Uniform Resource Locator (URL)
A URL is a specialized subset of URI. Not only does it pinpoint where a resource resides, but it also outlines the primary mechanism to retrieve it. This means that every URL is inherently a URI, but not all URIs qualify as URLs.

## Diving into the Syntax of URI

The structure of a URI is governed by specific rules, ensuring a standardized format.

```markdown
scheme:[//authority][/path][?query][#fragment]
```

- **Scheme**: For URIs, the scheme might be a protocol like HTTP or HTTPS. For URLs, the scheme goes beyond just a protocol—it represents the method used to access the associated resource.
- **Authority**: Often optional, this segment may contain user authentication details, host, and an occasional port.
- **Path**: Specifies a resource within its scheme and authority realm.
- **Query**: An extra layer of data that, combined with the path, pinpoints a resource. For URLs, this is typically the query string.
- **Fragment**: An optional section marking a specific fragment of the resource.

When distinguishing a URI's type, the scheme comes to the fore. Common URL schemes include _ftp_, _http_, _https_, and _mailto_. If a URI doesn't commence with any of these, it isn't a URL.

## Nuances in URI and URL Java Classes

Java offers classes for both URI and URL, each with distinct attributes and methods.

### Constructing URI and URL Instances

Instantiation in Java for both URI and URL is fairly alike. While both classes flaunt numerous constructors catering to most of its sections, only the URI class boasts a constructor that includes all parts of its syntax.

For instance, in Java:

```java
URI exampleURI = new URI("scheme", "user:password", "host", 80, "/path", "query", "fragment");
URL exampleURL = new URL("http", "host", 80, "/path/to/resource");
```

However, the URL class lacks a utility method analogous to _URI.create()_.

### Seamless Conversion Between URI and URL

Transitioning between URI and URL in Java is intuitive:

```java
URI sampleURI = new URI("http://example.com/path");
URL sampleURL = sampleURI.toURL();
```

Nevertheless, attempting to convert a non-URL URI could trigger exceptions.

### Remote Connections via URL

A URL's inherent nature as a reference to a remote entity empowers Java with methods to establish a connection to said resource and garner its contents.

```java
URL targetURL = new URL("http://example-site.com");
InputStream stream = targetURL.openStream();
```

It's crucial to acknowledge that the URL's _equals()_ and _hashcode()_ methods might invoke the DNS naming service, leading to inconsistencies dependent on network conditions. Utilizing URI is a more recommendable approach in such scenarios.

## JDK 20 and Beyond • Deprecation of _java.net.URL_ Constructors

In the recent update, the constructors for the _java.net.URL_ class have been marked as deprecated. This is highlighted in JDK enhancement [[JDK-8294241](https://bugs.openjdk.org/browse/JDK-8294241)].

Developers are now advised to lean towards the _java.net.URI_ class for parsing or crafting URLs. If there's a scenario where you specifically require an instance of _java.net.URL_ for initiating a connection, here's the recommended approach:

1. Utilize _java.net.URI_ to parse or build the URL string.
2. If validation is needed to ensure the authority component can be comprehended as a server-based authority, you can invoke _URI::parseServerAuthority()_.
3. Afterwards, to generate the _URL_ instance, employ the method _URI::toURL()_.

For more intricate use-cases, especially where a custom stream handler is necessary, a novel method named _URL::of(URI, URLStreamHandler)_ has been introduced.

Here's an example illustrating the recommended approach using _java.net.URI_ and the transition to _java.net.URL_:

```java
import java.net.URI;
import java.net.URL;

public class URLExample {
    public static void main(String[] args) {
        try {
            // Constructing a URI instance
            URI myUri = new URI("http://example.com");

            // Validating the authority component (optional)
            myUri.parseServerAuthority();

            // Converting URI to URL
            URL myUrl = myUri.toURL();
            System.out.println("Converted URL: " + myUrl);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

This example first creates a _URI_ instance from a string representation. After optional validation using _parseServerAuthority()_, it then converts this _URI_ to a _URL_ instance using _toURL()_. The resulting URL is then printed out.

For a more exhaustive understanding and further details, please refer to the official API documentation of _java.net.URL_.

## In Conclusion

In JDK 20, the _java.net.URL_ constructors saw deprecation, symbolizing a pivotal transition in Java's methodology for managing URLs. The development team now champions the adoption of _java.net.URI_ for the tasks of parsing or constructing URLs. This modification sheds light on the indispensable nature of discerning the differences between URI and URL within Java's framework. While both concepts are nuanced, they form the bedrock of web development and Java programming. This discourse seeks to provide an exhaustive insight into these concepts. Embracing these nuances and staying updated on the latest changes, such as the JDK 20 deprecation, empowers developers to optimize their code for both clarity and efficiency.
