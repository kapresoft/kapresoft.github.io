---
layout: kapresoft
title: Spring Boot Jackson and Lombok Best Practices
image: /assets/images/kapresoft.png
category: java
---

# 1. Overview

This article covers the Best Practices for Jackson and Lombok using Spring Boot.

<!--excerpt-->

# 2. Project

The maven project provided in this example used the spring initializr page https://start.spring.io to generate the initial source code.
 

## **2.1.** POM Dependencies

The spring initializr page configured the pom parent element as shown below.

```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>2.5.6</version>
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

## 2.2. Jackson

Jackson is a multi-purpose high-performance Java library used for serializing / deserializing byte streams into Java Data Transfer Objects. Developers also refer to the term "serialization" to be the same as Marshalling and Unmarshalling. The most common example is the serialization of JSON or XML byte streams into Java Objects.

## 2.3. Lombok

Lombok is a java library that developers use to eliminate boilerplate code such as getters and setters of a field. Lombok runs as an annotation project processor that adds generated code to your lombok-qualified classes at compile time. With the help of a plugin, most modern developer tools like IntelliJ or Visual Studio code support Lombok.

## 2.4. Components

#### 2.4.1. Data Transfer Object (DTO) Library
> A published java library that contains the Java classes used to serialize JSON strings

#### 2.4.2. Client App

> A generic client application that depends on the DTO library and executes RESTful calls to Account Service API and depends on the DTO library classes to serialize the outgoing JSON payload

#### 2.4.3. Account Service

> A restful service for managing accounts that depends on the DTO library to deserialize the incoming JSON payload.

#### 2.4.4. Create Account Service Sequence Diagram

![Account Service](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://gist.githubusercontent.com/kapresoft/3906af433fa7b8f2cf4c8a2041bf13e8/raw/9dfd9f5f68e92a2616068524fd23edece550f72d/account-service.uml)

[comment]: <> (Plant UML Source)
[comment]: <> (<script src="https://gist.github.com/kapresoft/3906af433fa7b8f2cf4c8a2041bf13e8.js"></script>)

## 2.5. Serialization and Deserialization

The JSON string below can be converted or deserialized into a Java Account class object instance.  In contrast, a Java Account class object instance can be converted or serialized into a JSON character stream.

**Deserialization**
- JSON String to Java Object

**Serialization**
- Java Object to JSON String

#### 2.5.1. JSON Representation of an Account

>For demonstration, this article uses the following JSON representation of an Account payload.

<script src="https://gist.github.com/kapresoft/4294056068aba51b3de244e1db045d90.js"></script>

# 3. Best Practices

## 3.1. Use Lombok

Use lombok so to cut the amount of ceremonial Java code via Annotations.   Use constructor annotations like _@Value_ to make the class immutable.

## 3.2. Make the Transport Objects Immutable

Benefits of Immutability

- Thread Safety / No Side Effects
- Simple, More Readable and Maintainable Code; Less Defensive Code
- Garbage Collection
- Less code (no setters or other method that changes state). 
- More readable code.  
- Can't change state after construction; 
- no setter methods; 
- easy to work with.
- After construction, objects can be passed around and can guarantee that the state is the same.
- An immutable object can't change state after construction, i.e. there are no setter or other methods that will modify the state of the object.
- No need to worry about passing in a data that could be manipulated.

`Fix Me`

#### 3.2.1. Immutable Account Class using Lombok @Value Annotation

Using the @Value annotation will produce a class with final properties or fields getter methods.  As shown on Lines 14-17 below that the 'private final' keywords can be omitted on the property fields.

> The following example utilizes the _Lombok_ @Value annotation which encapsulates the representation of a pure immutable java object.

<script src="https://gist.github.com/kapresoft/fe4e67bc8bd62efa4994c7fab8692e89.js"></script>

#### 3.2.2. Immutable Account Class without using Lombok @Value Annotation

>The following example is an alternate implementation of an Account class that doesn't use @Value, but instead uses @Getter and specifies explicitly additional annotations to represent a java immutable object.

The following java code is equivalent to the previous code using @Value with the addition of @AllArgsConstructor, @ToString, @EqualsAndHashCode, and @Getter annotations.

As you can see from this implementation that the first Account implementation in **3.2.1 Java Code #1** is less convoluted with Lombok Annotations.

<script src="https://gist.github.com/kapresoft/115d9cbcd185a328613ff92b0b7e5bdd.js"></script>

In the Sequence Diagram below, it demonstrates a simple call sequence where a client app calls _Account Service_ to create an Account.  Transparently, the JSON payload is converted to a Java Object in the service by calling the ObjectMapper#readValue(...).  The service executes a business logic and creates the Account and sends the response object back to the Client App calling the ObjectMapper#writeValue(...) to stream (i.e. serialize) the Java Object response back to the client.

#### 3.2.3. Immutability and Inheritance in Abstract Classes

[comment]: <> (Show Example of Parent-Child of two subclasses)

`Add me`

## 3.3. Provide Builder Classes and Copy Constructors

[comment]: <> (Convenience of having builder classes)
`Add me`

## 3.4. Order the properties

For readability of the JSON being generated, annotate the class with _JsonPropertyOrder_ so that the properties are ordered.  The downstream client application consuming the JSON file should not care about this.  Ordering your properties is also good for consistent results when signing or verifying data. 

Jackson provides several strategies for ordering the properties so pick what's best for what you're working on.

**See Also**
- MapperFeature.SORT_PROPERTIES_ALPHABETICALLY
- SerializationFeature.ORDER_MAP_ENTRIES_BY_KEYS

As shown on 3.2.1 code on Line 11, the JsonPropertyOrder is provided.

```java
@JsonPropertyOrder({"username", "email", "firstName", "lastName"})
```

[comment]: <> (TODO)

## 3.5. Silently Fail on Missing Properties during Deserialization

Silently fail on Missing Properties so that way deserialization continue to function correctly over newer versions of the Transport Object Library

For example, when a change occurs where a new field is introduced in Account class the deserialization won't fail. This requires a solid validation logic in the Service layer. Don't fail when new field is missing

- Client App updates to a version of the Transport Object library that contains a new version of the Account class introducing a new property
- Client App calls the Create Account API (POST /account)
- Account Service deserializes the JSON payload without failure
- Account Service can programmatically determine whether the Client App provided the new field and execute an new flow, otherwise existing business logic is executed.

[comment]: <> (TODO)

## 3.6. Use Annotations to Configure Jackson Objects

Given a Data Transport Library with plain-old objects using Jackson utilized by two applications.  The two applications communicate with each other via JSON RESTful APIs using the Data Transport Library. Both Applications utilize Spring Boot and Jackson XML.

#### Annotations can make the behavior uniform across JVMs or Applications; Configurations requires more management

In this scenario, both applications Serializes / Deserializes the JSON request/response uniformly.

[comment]: <> (Example code showing ObjectMapper configuration vs. Annotation)

#### Object Mapper Configuration requires similar configuration across JVMS and/or Applications.

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

The outcome is only the same if ObjectMapper is configured correctly. Serialization Configuration updates to the Data Transport Library may require change to both Applications configuring the ObjectMapper.

[comment]: <> (TODO)

## 3.7. Immutability in Sub-classes

[comment]: <> (Show and Parent / Child Example)
`Add Me`

## 3.8. Serialization Tests

[comment]: <> (TODO)
`Add Me`

## 3.9. Exclude generated code from code coverage tools

[comment]: <> (TODO)
`Add Me`
