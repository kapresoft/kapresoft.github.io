---
title: "Spring Boot, Jackson, and Lombok Best Practices"
title_style: title2
canonical_url: https://www.kapresoft.com/java/2023/04/12/spring-boot-jackson-and-lombok-best-practices.html
category: java
image: /assets/images/kapresoft1-210x.png
description: "Learn best practices for using Jackson and Lombok with Spring Boot to build enterprise-level Java apps"
---

## Overview

This article discusses the recommended practices for using Jackson and Lombok in conjunction with Spring Boot, a popular framework for building enterprise-level Java applications.<!--excerpt-->

<a id='C8ca3qDUQo5sUZAv41u3Sg' class='gie-single' href='http://www.gettyimages.com/detail/1258130605' target='_blank' style='color:#a7a7a7;text-decoration:none;font-weight:normal !important;border:none;display:inline-block;'>Embed from Getty Images</a><script>window.gie=window.gie||function(c){(gie.q=gie.q||[]).push(c)};gie(function(){gie.widgets.load({id:'C8ca3qDUQo5sUZAv41u3Sg',sig:'r5AkaTh021M8JrWiW7q__GvgmhVraw-FPPoygkMjGwQ=',w:'589px',h:'200px',items:'1258130605',caption: false ,tld:'com',is360: false })});</script><script src='//embed-cdn.gettyimages.com/widgets.js' charset='utf-8' async></script>

## Jackson & Project Lombok
Jackson is a high-performance JSON parsing and serialization library used to convert JSON data into Java objects and vice versa. Lombok is a code generation library that simplifies the creation of Java classes by generating boilerplate code, such as getters, setters, constructors, and equals/hashCode methods.

The article highlights the benefits of using Jackson and Lombok together and explains how to configure them in a Spring Boot application. It also provides guidelines for using Jackson annotations and Lombok annotations effectively to avoid common pitfalls and improve code quality.

By following the best practices outlined in this article, developers can streamline their development process, improve performance, and reduce the likelihood of errors and bugs in their code.

## POM Dependencies

The spring initializr page configured the pom parent element as shown below.

```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.0.5</version>
    <relativePath/> <!-- lookup parent from repository -->
</parent>
```

The dependencies block will include jackson-databind and lombok.  Note that developers should avoid specifying the version of the dependency sot that it will default to the spring-boot-provided version as defined in the jackson-bom-&lt;version&gt;.pom file.

Spring boot is packaged and tested with the default jackson-databind version in the bom file and should be beneficial to use.  Developers may override the dependency version of the spring-boot-provided dependencies by specifying a different version.

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter</artifactId>
    </dependency>
    <dependency>
        <groupId>org.projectlombok</groupId>
        <artifactId>lombok</artifactId>
        <optional>true</optional>
    </dependency>
    <dependency>
        <groupId>com.fasterxml.jackson.core</groupId>
        <artifactId>jackson-databind</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>

```

Avoid declaring the version as such unless it is necessary:

```xml
<dependencies>
    <dependency>
        <groupId>com.fasterxml.jackson.core</groupId>
        <artifactId>jackson-databind</artifactId>
        <version>2.12.5</version> <!-- <== omit this part -->
    </dependency>
</dependencies>
```

See the full project pom.xml here: [link]

#### Jackson

Jackson is a multi-purpose high-performance Java library used for serializing / deserializing byte streams into Java Data Transfer Objects. Developers also refer to the term "serialization" to be the same as Marshalling and Unmarshalling. The most common example is the serialization of JSON or XML byte streams into Java Objects.

#### Lombok

Lombok is a java library that developers use to eliminate boilerplate code such as getters and setters of a field. Lombok runs as an annotation project processor that adds generated code to your lombok-qualified classes at compile time. With the help of a plugin, most modern developer tools like IntelliJ or Visual Studio code support Lombok.

## Architectural Components

### Data Transfer Object (DTO) Library

A Java DTO library intended for clients, comprising of classes used for serializing JSON strings.  DTO stands for Data Transfer Object. It is a design pattern commonly used in software engineering to transfer data between different layers of an application, such as between the front-end and back-end or between microservices.

By providing a DTO library for Java-based clients, it is possible to version the library along with the release of API versions. This ensures that the DTOs used by the clients match the DTOs used by the API, thereby avoiding any versioning issues or incompatibilities.

### Java Client App

An example java-based client application that relies on the DTO library and performs RESTful requests to the Account Service API, utilizing the DTO library's classes to serialize the outgoing JSON payload.

### Account API

An API designed to manage accounts in a RESTful manner, which relies on the DTO library to deserialize the JSON payload received.

### Create Account Service Sequence Diagram

The sequence diagram presented below provides a simplified overview of how serialization takes place for each request-response sequence within the API. In Spring Boot, this process is automatically handled in a seamless manner, which may seem almost magical to some.

![Account Service](https://www.plantuml.com/plantuml/svg/ZT31YeCm40RWkqynvAIWx7qHKJpjmgAiorvA3p7EmJOc8PaWVVkcg53jfQV0d-IRdoaTSKj-aX6hvOYAe3A6GLO0guJG_X6qN-mJsgRxWm--PD7pvVBwcukhqmgQ_eA2VhWnQCCtYtpuvz9ZtDy8JsTmLgHGI-vSlXf5Sk1UXul04AvPl9x9-orcEn8kDHfFnbD7GPn0UqfXGnJEcxnVHfvbnqA_w8nM3c7d9L69QWZBl0C0)

[//]: <> (Plant UML Source: https://www.plantuml.com/plantuml/uml/ZT31YeCm40RWkqynvAIWx7qHKJpjmgAiorvA3p7EmJOc8PaWVVkcg53jfQV0d-IRdoaTSKj-aX6hvOYAe3A6GLO0guJG_X6qN-mJsgRxWm--PD7pvVBwcukhqmgQ_eA2VhWnQCCtYtpuvz9ZtDy8JsTmLgHGI-vSlXf5Sk1UXul04AvPl9x9-orcEn8kDHfFnbD7GPn0UqfXGnJEcxnVHfvbnqA_w8nM3c7d9L69QWZBl0C0)
[//]: <> (<script src="https://gist.github.com/kapresoft/3906af433fa7b8f2cf4c8a2041bf13e8.js"></script>)

The Sequence Diagram presented above illustrates a straightforward call sequence, wherein a client application requests the creation of an Account via the Account API. The JSON payload is automatically converted to a Java Object within the service by invoking the _ObjectMapper#readValue(...)_ method, which operates transparently in the background. 

The service subsequently executes its business logic and generates an Account object, which is then returned as a response to the calling client application. The _ObjectMapper#writeValue(...)_ method is utilized to stream, or serialize, the Java Object response and transmit it back to the client.

## Serialization and Deserialization

The given JSON string can be deserialized into an instance of the Java Account class, and similarly, an instance of the Java Account class can be serialized into a JSON character stream. While serialization encompasses both serialization and deserialization, this article will specifically use the term "deserialization" to refer to the deserialization process.

**Deserialization**
- JSON String to Java Object

**Serialization**
- Java Object to JSON String

### JSON Representation of an Account

As an example, here is a JSON representation of an Account payload:

<script src="https://gist.github.com/kapresoft/4294056068aba51b3de244e1db045d90.js"></script>

## Best Practices

### Data Transport Objects

#### Use lombok so to cut the amount of ceremonial Java code via Annotations

Constructor annotations, such as _@Value_, can be used in Java to create immutable classes. Immutability refers to the property of an object whose state cannot be modified once it has been created. By marking a class with the _@Value_ annotation, Lombok generates an immutable constructor and makes all the class fields final, preventing them from being modified. This can help prevent bugs and errors caused by unintended changes to object state, making code more reliable and easier to reason about. 

Immutable objects also facilitate safe sharing of data between threads in a multi-threaded application, as they are inherently thread-safe. Therefore, using constructor annotations like _@Value_ can help improve code quality and maintainability, especially in large and complex codebases.

#### Make the Data Transport Objects Immutable to get the benefits of immutability

To take advantage of immutability, it is recommended to make Data Transport Objects (DTOs) immutable. This means that once a DTO object is created, its state cannot be changed. Immutable DTOs provide several benefits, such as making code more reliable and easier to reason about, and ensuring thread-safety in multithreaded applications. 

By preventing unintended changes to object state, immutable DTOs can help prevent bugs and errors in code. Therefore, it is a good practice to make DTOs immutable when designing a Java application.

#### Immutable Account Class using Lombok @Value Annotation

Using the _@Value_ annotation will produce a class with final properties or fields getter methods.  As shown on Lines 14-17 below that the 'private final' keywords can be omitted on the property fields.

The following example utilizes the Lombok _@Value_ annotation which encapsulates the representation of a pure immutable java object.

<script src="https://gist.github.com/kapresoft/fe4e67bc8bd62efa4994c7fab8692e89.js"></script>

#### Immutable Account Class without using Lombok @Value Annotation

The following example is an alternate implementation of an Account class that doesn't use _@Value_, but instead uses _@Getter_ and specifies explicitly additional annotations to represent a java immutable object.

The following java code is equivalent to the previous code using @Value with the addition of @AllArgsConstructor, @ToString, @EqualsAndHashCode, and @Getter annotations.

As you can see from this implementation that the first Account implementation using _@Value_ is a little less convoluted than implementing with _@Getter_ and _@Setter_, but are essentially equivalent code when generated by the Lombok annotation processor.

<script src="https://gist.github.com/kapresoft/115d9cbcd185a328613ff92b0b7e5bdd.js"></script>

#### Provide Builder Classes and Copy Constructors

Providing Builder classes and Copy Constructors can be very helpful for Java clients that need to interact with an API. Builder classes allow for flexible object creation, where specific object attributes can be set during instantiation. This allows for easy customization of objects without having to create multiple constructors or rely on setters. Additionally, Builder classes can also enforce mandatory fields and provide default values for optional ones.

Copy Constructors, on the other hand, allow for easy creation of new objects by copying the state of an existing one. This can be particularly useful when needing to create similar but slightly different objects, as it avoids the need to manually copy each attribute. Copy Constructors also help with maintaining immutability, as a new object is created each time, rather than modifying the existing one.

By providing these functionalities to Java clients, it can greatly simplify the usage of an API and make it more user-friendly. This can lead to better adoption of the API and increased developer productivity. 

Please refer to this article to learn more about builders and copy constructors:
- [Lombok Builders & Copy Constructors](/java/2021/12/27/lombok-builders-and-copy-constructors.html).

### Jackson Serialization

#### Order the Object Properties

To enhance the readability of the generated JSON, it is recommended to annotate the class with JsonPropertyOrder, which will arrange the properties in a specific order. However, it is important to note that the downstream client application consuming the JSON file should not rely on the order of the properties and should be able to deserialize the JSON regardless of its order.

Ordering the properties also has benefits beyond readability, such as providing consistent results when signing or verifying data. This can be particularly important in security-sensitive applications, where data integrity is paramount. By ensuring a consistent order of properties, potential errors or issues can be detected more easily, leading to faster issue resolution and overall system stability. 

Jackson provides several strategies for ordering the properties so pick what's best for what you're working on.

**See Also**
- MapperFeature.SORT_PROPERTIES_ALPHABETICALLY
- SerializationFeature.ORDER_MAP_ENTRIES_BY_KEYS

Here is an example of the _@JsonPropertyOrder_ annotation at the class level

```java
@JsonPropertyOrder({"username", "email", "firstName", "lastName"})
```

[comment]: <> (TODO)

#### Silently Fail on Missing Properties for Deserialization

To ensure seamless deserialization across different versions of the Transport Object Library, it is recommended to handle missing properties gracefully by silently failing. This means that if a property is missing from the incoming JSON payload, the deserialization process will not throw an exception, but instead will continue to function correctly by setting the missing property to a default value or null.

By silently failing on missing properties, you can avoid breaking changes when new versions of the Transport Object Library are introduced. This can be particularly important in distributed systems where different components may be running different versions of the library. By handling missing properties gracefully, you can ensure that the deserialization process continues to function correctly, even if the incoming JSON payload is slightly different than expected.

For example, when a change occurs where a new field is introduced in Account class the deserialization won't fail. This requires a solid validation logic in the Service layer. Don't fail when new field is missing

- Client App updates to a version of the Transport Object library that contains a new version of the Account class introducing a new property
- Client App calls the Create Account API (POST /account)
- Account Service deserializes the JSON payload without failure
- Account Service can programmatically determine whether the Client App provided the new field and execute an new flow, otherwise existing business logic is executed.

[comment]: <> (TODO)

#### Use Annotations to Configure Jackson Objects instead of Object Mapper Configuration

To configure Jackson objects in a Data Transport Library used by multiple applications communicating via JSON RESTful APIs, annotations can be used to simplify the configuration process. The library may consist of plain-old objects that are serialized and deserialized using Jackson in conjunction with Spring Boot and Jackson XML.

By leveraging annotations, the configuration process can be streamlined and made more concise, reducing the amount of boilerplate code required. This can result in cleaner and more maintainable code, as well as faster development cycles. Additionally, using annotations can make it easier to ensure consistency across different components of the system that use the Data Transport Library, further improving overall system stability and reliability.

##### Using Jackson Annotations

Using annotations in a Java application can help to ensure uniform behavior across different JVMs or applications. This is because annotations provide a standardized way to apply metadata to classes and methods, which can help to ensure consistent behavior across different components of the system.

In contrast, configuration files often require more management, as they can be more difficult to maintain and manage as the system grows in complexity. With annotations, the configuration information is directly embedded within the code, which can make it easier to understand and modify. Additionally, annotations can provide better compile-time checking, since they are part of the code itself, reducing the likelihood of runtime errors due to misconfiguration. Overall, using annotations can be a powerful tool for ensuring consistency and maintainability in complex Java applications.

##### Using Object Mapper Configuration 

Object Mapper Configuration requires similar configuration across JVMs and/or Applications. Object Mapper configuration is an important aspect of Java applications that rely on serialization and deserialization of Java objects to and from JSON format. This process is handled by libraries such as Jackson, which provides a powerful and flexible way to map Java objects to and from JSON data. However, configuring the Object Mapper can be a complex task, and ensuring that the configuration is consistent across different JVMs or applications can be a challenge.

When multiple JVMs or applications are involved in the serialization and deserialization process, it is important to ensure that the Object Mapper is configured consistently across all components of the system. This includes setting up the appropriate serialization and deserialization rules, managing custom serializers and deserializers, and configuring other options such as date formats and property naming conventions. Failure to maintain consistency in Object Mapper configuration can lead to unexpected behavior, such as errors during serialization or deserialization, or differences in the generated JSON output.

To avoid these issues, it is important to carefully manage Object Mapper configuration, and ensure that any changes are carefully tested and deployed across all components of the system. This may require developing standardized configuration templates or libraries that can be easily shared across different JVMs or applications, or using tools that can automatically synchronize configuration settings across multiple instances of the Object Mapper. Ultimately, consistent and well-managed Object Mapper configuration is key to ensuring the smooth and reliable operation of Java applications that rely on JSON serialization and deserialization.

[comment]: <> (Example code showing ObjectMapper configuration vs. Annotation)

```java
ObjectMapper mapper = new ObjectMapper();
mapper.setFeature(..FEATURE1..);
mapper.setFeature(..FEATURE2..);
mapper.setFeature(..FEATURE3..);
```

Application #1:
- Configures ObjectMapper
- Serializes / Deserializes Transport Objects

Application #2:
- Configures ObjectMapper
- Serializes / Deserializes Transport Objects

If the ObjectMapper is not configured correctly, the outcome of serialization may differ. This means that any updates to the Data Transport Library's serialization configuration may require changes to be made to the configuration of the ObjectMapper in both applications.

### Serialization Tests

Unit testing the serialization of Data Transport Objects (DTOs) is an important aspect of ensuring the integrity of your application's data transport layer. By performing unit tests on the serialization process, you can verify that the data being transmitted is correctly serialized and formatted according to the expected format. 

Additionally, you can also ensure that any changes made to the DTOs or their serialization process do not negatively affect the behavior of the application. This can help to catch any potential bugs or issues early on in the development cycle, saving time and resources down the line. 

Unit testing the serialization of DTOs can be accomplished using various testing frameworks and libraries in conjunction with the appropriate mocking and assertion techniques.

#### Production or Live Site Serialization Bugs

When bugs are encountered in production or a live site, it can be difficult to identify the root cause and fix the issue without causing further problems. 

One approach to addressing this is to use unit tests to verify the behavior of the code and ensure that it is functioning as expected. By feeding back serialization bugs experienced in production into unit tests, developers can create more robust test suites that are better able to identify issues and prevent them from recurring. This can also help to catch potential regressions that may occur when changes are made to the codebase, allowing developers to catch and fix issues before they are deployed to production. 

Additionally, this approach can help to improve the overall quality of the codebase and reduce the number of bugs and issues that are experienced by end-users.


### Exclude Generated Code

Omitting generated code from analysis by code coverage tools is widely accepted as a recommended approach.

Please refer to this article to learn more about excluding generated code from test coverage: 
- [Lombok • Exclude Generated Code From Test Coverage](/java/2023/03/13/lombok-exclude-generated-code-from-test-coverage.html)

