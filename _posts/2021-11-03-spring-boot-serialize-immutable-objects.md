---
title: "Spring Boot • Serialize Immutable Objects"
canonical_url: https://www.kapresoft.com/java/2021/11/03/spring-boot-serialize-immutable-objects.html
image: /assets/images/kapresoft1-210x.png
category: java
description: "Serialize immutable objects using Jackson and Lombok in Spring Boot."
---

## Overview

This article illustrates how to serialize and write tests for immutable objects using Jackson and Lombok in Spring Boot.

<!--excerpt-->

## Project

The maven project provided in this example used the spring initializr page https://start.spring.io to generate the initial source code.

The github repository that this article references can be found in [https://github.com/kapresoft/spring-boot-serialize-immutable-objects](https://github.com/kapresoft/spring-boot-serialize-immutable-objects).

For checking out and building the Spring Boot project, please refer to the [README](https://github.com/kapresoft/spring-boot-serialize-immutable-objects/blob/main/README.md) documentation on the github repository.

### POM Dependencies

The spring initializr page configured the pom parent element as shown below.

```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>2.5.6</version>
    <relativePath/> <!-- lookup parent from repository -->
</parent>
```

The dependencies block will include jackson-databind and lombok.  Note that developers should avoid specifying the version of the dependency so that the build will default to the spring-boot-provided version defined in the jackson-bom-&lt;version&gt;.pom file.

Spring boot is packaged and tested with the default lombok version in the bom file and should be beneficial to use.  Developers may override the dependency version of the spring-boot-provided dependencies by specifying a different version.

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

See the full project [pom.xml](https://github.com/kapresoft/spring-boot-serialize-immutable-objects/blob/main/pom.xml)

### Jackson

Jackson is a multi-purpose high-performance Java library used for serializing / deserializing byte streams into Java Data Transfer Objects. Developers also refer to the term "serialization" to be the same as Marshalling and Unmarshalling. The most common example is the serialization of JSON or XML byte streams into Java Objects.

### Lombok

Lombok is a java library that developers use to eliminate boilerplate code such as getters and setters of a field. Lombok runs as an annotation project processor that adds generated code to your lombok-qualified classes at compile time. With the help of a plugin, most modern developer tools like IntelliJ or Visual Studio code support Lombok. In addition, the Lombok @Builder annotation is also used in this article to simplify the creation of new objects through builder factory methods.

### AssertJ

AssertJ is a fluent assertion framework is an extensible component that is included with the base spring boot starter project.  The framework provides readability, fluent method assertion flow, continuity, and auto-completion of methods if using an IDE.  The assertion framework also encourages eliminating code duplication in your test code. There are many other benefits provided by AssertJ compared to the standard JUnit assertions.

Please visit [AssertJ Document](https://assertj.github.io/doc/) for more details.

### Serialization Unit Tests

As a basic rule for developers, Unit Testing guarantees that all code meets quality standards before it's deployed. In addition, existing Unit Tests can be used to verify a bug that may be discovered in production in the future.

Over the course of the Software Development Life Cycle (SDLC), testing your code documents the behavior, saves time and money, aids in verification and diagnostic work, and finally helps developers write better code in less time.

Writing Serialization tests for your Java Data Transport Objects are essentially cheap and easy to maintain along with utilizing an assertion framework like AssertJ.

### Benefits of Immutability

Immutable objects are thread-safe and the state of the objects cannot be modified once created. Developers do not need to worry about passing in data that could be manipulated. After construction, objects can be handed-off downstream without side effects.  

## Serialization of Immutable Objects

Jackson provides a mechanism called Object Serialization or Deserialization where an object can be represented as JSON, XML, and others formats.  This tutorial will only demonstrate serialization of JSON data to and from a Java Object.

The JSON string below can be converted or deserialized into a Java Account class object instance.  In contrast, a Java Account class object instance can be converted or serialized into a JSON character stream.

**Serialization**
- Java Object to JSON String

**Deserialization**
- JSON String to Java Object

### JSON Representation of an Account

For demonstration, this article uses the following JSON representation of an Account payload.

<script src="https://gist.github.com/kapresoft/4294056068aba51b3de244e1db045d90.js"></script>

### Immutable Account Class using Lombok @Value Annotation

The following example utilizes the _Lombok_ @Value annotation to conveniently write a Java class whose instance is an immutable object.

Using the @Value annotation will produce a class with final properties or fields getter methods, a _toString()_ and _hashCode()_ methods.  As shown on Lines 14-17 below, the **'private final'** keywords are omitted on the property fields. Lombok will implicitly update the generated code with a 'private final' field. This allows developers to write less ceremonial code. How cool is that?

<script src="https://gist.github.com/kapresoft/fe4e67bc8bd62efa4994c7fab8692e89.js"></script>

The java source can be viewed here for [Account.java](https://github.com/kapresoft/spring-boot-serialize-immutable-objects/blob/main/src/main/java/com/kapresoft/springboot/serializeimmutableobjects/dto/simple/Account.java).

##### Unit Test for Converting Account Object to JSON String (Serialization)

For a given Account instance with values, the following unit test demonstrates the serialization of the java object into a JSON string.

```java
@Test
void canSerializeAccount() throws JsonProcessingException {
    final Account account = Account.builder()
            .email("johndoe@gmail.com").username("johndoe")
            .firstName("John").lastName("Doe")
            .build();
    final String jsonText = mapper.writeValueAsString(account);
    final String expectedJSON = "{\"username\":\"johndoe\",\"email\":\"johndoe@gmail.com\",\"firstName\":\"John\",\"lastName\":\"Doe\"}";
    assertThat(jsonText).as("Expected Account JSON")
            .isEqualTo(expectedJSON);
}
```

The java source can be viewed here for [AccountSerializationTest.java](https://github.com/kapresoft/spring-boot-serialize-immutable-objects/blob/main/src/test/java/com/kapresoft/springboot/serializeimmutableobjects/simple/AccountSerializationTest.java#L27-L37).

##### Unit Test for Converting JSON String to Account Object (Deserialization)

Given the following JSON string content depicted in section 3.1, the following unit test demonstrates the JSON deserialization into an Account object.

```java
@Test
void canDeserializeAccountJSON() throws JsonProcessingException {
    // See section 3.1 for the JSON string
    final Account account = mapper.readValue(JSON, Account.class);
    assertThat(account).as("Account")
        .isNotNull();
    assertThat(account.getUsername()).as("Username")
        .isEqualTo("kapre");
    assertThat(account.getEmail()).as("Email")
        .isEqualTo("kapre@kapresoft.com");
}
```

The java source can be viewed here for [AccountSerializationTest.java](https://github.com/kapresoft/spring-boot-serialize-immutable-objects/blob/main/src/test/java/com/kapresoft/springboot/serializeimmutableobjects/simple/AccountSerializationTest.java#L39-L48).

### Immutable Account Class without using Lombok @Value Annotation

The following example is an alternate implementation of an Account class in the previous section that doesn't use @Value, but instead uses @Getter and specifies explicitly additional annotations to represent a java immutable object.

In the previous section the @Value represented an annotation provided by Lombok to represent a series of configuration that will generate code during compile time representing an immutable class.  Developers can choose not to use @Value for design reasons and doing so will require adding or unwrapping the other required Lombok annotations.

The following java code is equivalent to the previous code using @Value with the addition of @AllArgsConstructor, @ToString, @EqualsAndHashCode, and @Getter annotations.

As you can see from this implementation that the first Account implementation in **3.2** is less convoluted with Lombok Annotations.

Either use of Lombok @Value or the explicit @Getter shown on sections 3.2 and 3.3 should not affect testability.  The test written for 3.2 implementation should pass for 3.3 and vice versa.

<script src="https://gist.github.com/kapresoft/115d9cbcd185a328613ff92b0b7e5bdd.js"></script>

The java source can be viewed here for [AccountWithoutUsingValue.java](https://github.com/kapresoft/spring-boot-serialize-immutable-objects/blob/main/src/main/java/com/kapresoft/springboot/serializeimmutableobjects/dto/simple/AccountWithoutUsingValue.java).

##### Unit Test for Converting AccountWithoutUsingValue Object to JSON String (Serialization)

For a given AccountWithoutUsingValue instance with values, the following unit test demonstrates the serialization of the java object into a JSON string.

```java
@Test
void canSerializeAccount_WithoutUsingValue() throws JsonProcessingException {
    final AccountWithoutUsingValue account = AccountWithoutUsingValue.builder()
            .email("johndoe@gmail.com").username("johndoe")
            .firstName("John").lastName("Doe")
            .build();
    final String jsonText = mapper.writeValueAsString(account);
    final String expectedJSON = "{\"username\":\"johndoe\",\"email\":\"johndoe@gmail.com\",\"firstName\":\"John\",\"lastName\":\"Doe\"}";
    assertThat(jsonText).as("Expected Account JSON")
            .isEqualTo(expectedJSON);
}
```

The java source can be viewed here for [AccountSerializationTest.java](https://github.com/kapresoft/spring-boot-serialize-immutable-objects/blob/main/src/test/java/com/kapresoft/springboot/serializeimmutableobjects/simple/AccountSerializationTest.java#L50-L60).

##### Unit Test for Converting JSON String to AccountWithoutUsingValue Object (Deserialization)

Given the following JSON string content depicted in section 3.1, the following unit test demonstrates the JSON deserialization into an AccountWithoutUsingValue object.

```java
@Test
void canDeserializeAccountJSON_WithoutUsingValue() throws JsonProcessingException {
    // See section 3.1 for the JSON string
    final AccountWithoutUsingValue account = mapper.readValue(JSON, AccountWithoutUsingValue.class);
    assertThat(account).as("Account")
        .isNotNull();
    assertThat(account.getUsername()).as("Username")
        .isEqualTo("kapre");
    assertThat(account.getEmail()).as("Email")
        .isEqualTo("kapre@kapresoft.com");
}
```

The java source can be viewed here for [AccountSerializationTest.java](https://github.com/kapresoft/spring-boot-serialize-immutable-objects/blob/main/src/test/java/com/kapresoft/springboot/serializeimmutableobjects/simple/AccountSerializationTest.java#L62-L71).

### Immutability and Inheritance

Immutability and Lombok also works well with a hierarchical or parent-child object structure.  HierarchicalAccount class which extends from a BaseAccount class is implemented in Jackson as shown in the next two sections.

#### BaseAccount Class

The BaseAccount is an abstract class and must declare a @Getter annotation for the property getter methods.

<script src="https://gist.github.com/kapresoft/496f1dad190333b9aab9d9bb090a4b83.js"></script>

The java source can be viewed here for [BaseAccount.java]( https://github.com/kapresoft/spring-boot-serialize-immutable-objects/blob/main/src/main/java/com/kapresoft/springboot/serializeimmutableobjects/dto/hierarchical/BaseAccount.java)

#### HierarchicalAccount Class

For this parent-child hierarchical structure, the figure below shows that HierarchicalAccount class extends from the parent BaseAccount class.

**Figure 3.4.2.1.**  HierarchicalAccount Class Diagram

<a href="/assets/img/jackson-serializable-hierarchy.png"><img alt="Hierarchical Account Class Diagram" src="/assets/img/jackson-serializable-hierarchy.png" title="Hierarchical Account Class Diagram" width="400"/></a>

Lombok updates to handle a hierarchical structure:

1. Annotate the type with @EqualsAndHashCode(callSuper = true)
   - Hints Lombok code generation to take into account the parent class hashCode() method when generating its own hashCode() method.
2. Call the parent _super(username: String, email: String)_ method
   - Initializes the parent class constructor accordingly.

<script src="https://gist.github.com/kapresoft/025aeb9930e6356baf119b03caa7edc9.js"></script>

The java source can be viewed here for [HierarchicalAccount.java]( https://github.com/kapresoft/spring-boot-serialize-immutable-objects/blob/main/src/main/java/com/kapresoft/springboot/serializeimmutableobjects/dto/hierarchical/HierarchicalAccount.java)

##### Unit Test for Converting HierarchicalAccount Object to JSON String (Serialization)

For a given HierarchicalAccount instance with values, the following unit test demonstrates the serialization of the java object into a JSON string.

```java
@Test
void canSerializeHierarchicalAccount() throws JsonProcessingException {
    final HierarchicalAccount account = HierarchicalAccount.builder()
            .email("johndoe@gmail.com").username("johndoe")
            .firstName("John").lastName("Doe")
            .build();
    final String jsonText = mapper.writeValueAsString(account);
    final String expectedJSON = "{\"username\":\"johndoe\",\"email\":\"johndoe@gmail.com\",\"firstName\":\"John\",\"lastName\":\"Doe\"}";
    assertThat(jsonText).as("Expected Account JSON")
            .isEqualTo(expectedJSON);
}
```

The java source can be viewed here for [HierarchicalAccountSerializationTest.java](https://github.com/kapresoft/spring-boot-serialize-immutable-objects/blob/main/src/test/java/com/kapresoft/springboot/serializeimmutableobjects/hierarchical/HierarchicalAccountSerializationTest.java#L26-L36).

##### Unit Test for Converting JSON String to HierarchicalAccount Object (Deserialization)

Given the following JSON string content depicted in section 3.1, the following unit test demonstrates the JSON deserialization into an HierarchicalAccount object.

```java
@Test
void canDeserializeHierarchicalAccount() throws JsonProcessingException {
    // See section 3.1 for the JSON string
    final HierarchicalAccount account = mapper.readValue(JSON, HierarchicalAccount.class);
    assertThat(account).as("Account")
            .isNotNull();
    assertThat(account.getUsername()).as("Username")
            .isEqualTo("kapre");
    assertThat(account.getEmail()).as("Email")
            .isEqualTo("kapre@kapresoft.com");
}
```

The java source can be viewed here for [HierarchicalAccountSerializationTest.java](https://github.com/kapresoft/spring-boot-serialize-immutable-objects/blob/main/src/test/java/com/kapresoft/springboot/serializeimmutableobjects/hierarchical/HierarchicalAccountSerializationTest.java#L38-L47).

## Summary

This article in summary discussed the following points:

- Discussed usage and simplicity of using Lombok @Value and @Getter for Immutable Objects.
- Demonstrated the use of Jackson and Lombok on hierarchical or parent-child class structures.
- Speed, Maintainability and the cleanliness of code when using Lombok Annotations.
- Provided Unit Tests to verify serialization of java objects and deserialization into JSON strings.
