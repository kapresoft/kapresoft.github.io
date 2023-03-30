---
title: "Lombok • Builders and Copy Constructors"
canonical_url: https://www.kapresoft.com/java/2021/12/27/lombok-builders-and-copy-constructors.html
image: /assets/images/kapresoft1-210x.png
category: java
description: "Discover how Lombok's @Builder simplifies implementing the Builder Pattern and Copy Constructors in OOP, improving code maintainability."
---

## Overview

Lombok's builder and copy constructor feature using _[@Builder](https://projectlombok.org/features/Builder)_ is a mechanism that allows the implementation of the _Builder Pattern_ and _Copy Constructors_ in Object-Oriented Programming.  This article further illustrates how Lombok mitigates the disadvantages of creating builder methods and copy constructors making Lombok's @Builder a good foundation for design and code maintainability.

<!--excerpt-->

## Project

For simplicity and speed of development the maven project provided in this example used the spring initializr page [https://start.spring.io](https://start.spring.io) to generate the initial source code.

### POM Dependencies

The spring initializr page configured the pom parent element as shown below.

```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>2.5.6</version>
    <relativePath/>
</parent>

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
</dependencies>
```
The dependencies block will include lombok. The tested, recommended and beneficial version of lombok version to use is specified in the spring-boot-dependencies-&lt;version&gt;.pom file that is packaged with the spring boot library.  

As an example, after initially building the project with maven, you will find the following file in your local maven .m2 cache directory.

Line #141 on the pom file in the link and figure below shows the specified version of lombok.

$HOME/.m2/repository/<a target="_blank" href="https://gist.github.com/kapresoft/05f5d652767b30c885b8290a3ea937b3#file-spring-boot-dependencies-2-6-1-pom-L140-L142">org/springframework/boot/spring-boot-dependencies/2.6.1/spring-boot-dependencies-2.6.1.pom</a>

<div class="figure"><span class="title">Figure 1.</span>Lombok Version Configured in Spring Dependencies POM</div>
![Lombok Version in POM](/assets/img/lombok-version.webp)


Developers may override the lombok version as needed in the properties section of the local project pom.xml file

**Properties Section**

```xml
<properties>
    <!-- ...other properties-->
    <lombok.version>[TARGET-LOMBOK-VERSION]</lombok.version>
    <!-- Example
    <lombok.version>1.18.22</lombok.version>
    -->
</properties>
```

## Builders

Builders are methods designed to aid developers in creating objects.  This design is also referred to as the Builder Pattern are one of the original The [Gang of Four (GoF)](https://en.wikipedia.org/wiki/Design_Patterns) patterns referred to by the four authors ( Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides) of the book _Design Patterns: Elements of Reusable Object-Oriented Software (1994)._

### Benefits of Builders

Builders allow developers to "encapsulate" code for construction and representation and provides "control" over the code of the construction process.

### Disadvantages

1. A concrete builder must be created for each object creation.
2. Builder classes should be mutable.
3. May hamper or complicate dependency injection.

Lombok, in general, mitigates the above pain points by making it convenient for developers to handle boilerplate code. Eliminating boilerplate code in creating a builder method is an attractive option for implementing the Builder Pattern. 

## Copy Constructors

Copy constructors allow a new object to be created from an existing object of the same class, as a copy of an existing object.  If this operation is beneficial for a particular business process is executing a few copies.

Copy constructors are newly instantiated objects that are independent of the original instance. An immutable object can be transformed to another object with new immutable field values and passed on to downstream services without affecting the original instance.

One caveat worth mentioning is that copy constructor are not inheritable by subclasses.  However, lombok provides an _experimental_ feature that allows this type of structure via the lombok annotation _@SuperBuilder_.

### Mutable Classes

```java
@Data
@SuperBuilder(toBuilder=true)
public class SuperUser extends User {
}

@Data
@SuperBuilder(toBuilder=true)
public class User {
}
```
### Immutable Classes

For an immutable Parent/Child relationship, a minor change should suffice by unwrapping some _@Value_ compounded annotations.

The most convenient way to create an immutable class in Lombok is to use the _@Value_ annotation instead of _@Data_.  The _@Value_ annotation represents a compound of annotations for the code generation process of an immutable class.  In this scenario, we want to avoid using _@Value_ since this will mark the parent class _User_ as final preventing class _SuperUser_ from extending it.

To transform our mutable classes to immutable ones, the changes and annotations are as follows:

- Class User and SuperUser Constructor Annotations
  - @SuperBuilder(toBuilder=true)    `// experimental`
  - @EqualsAndHashCode(callSuper = true)
  - @SuperBuilder(toBuilder = true)
- Class User fields
  * use _@Getter_ add private keyword

```java
@Value
@EqualsAndHashCode(callSuper = true)
@SuperBuilder(toBuilder = true)
public class SuperUser extends User {

    @Singular
    List<String> permissions;
    
    @Override
    public boolean isSuperUser() {
        return true;
    }
    
}

@SuperBuilder(toBuilder = true)
@EqualsAndHashCode
@AllArgsConstructor
@ToString
public class User {

    @Getter
    String firstName;
    @Getter
    String lastName;
    @Getter
    String email;
    
    public boolean isSuperUser() {
        return false;
    }

}
```

## Caveats for Both Builder and Copy Constructors

1. Maintenance
   - In Lombok, since the code is generated and can be ignored during test coverage, the maintenance is no longer an issue. Item #4 below still applies.
2. Bloated Objects
   - The developer is editing the non-bloated lombok version of the class but there is a danger of annotation bloating.
3. Noise for Test Coverage
   - can be mitigated by hinting the build process to ignore these generated code in maven (or gradle).  This is a valid option because we don't want to "Test the Framework"
4. Changes in code generation code potentially introduce bugs downstream
   - Mitigated by having appropriate unit tests on business critical methods



## Example Use Cases

### ETL Use Case

A valid use case for builder and copy constructors could be if a situation exists where a developer needs to create user objects with base properties avoiding code duplication.  This pattern normally occurs on data migration or during an ETL process where coding is involved.

Note that the _.builder()_ is the builder method and _.toBuilder()_ is the copy constructor in this example.  These method names are the default method names in Lombok and can be configured to have different method names.

```java
User baseUser = User.builder()
                    .role("User")
                    .company("Acme Corporation").build();
User roadRunner = user.toBuilder()
                      .email("road.runner@gmail.com").build();
User wileECoyote = user.toBuilder()
                       .email("wile.e.coyote@gmail.com").build();
```

### Deep Copies of Objects with Immutable fields for Updates

#### Incremental Update of Object fields

If we are dealing with a pure immutable object, we can retrieve the current state, create a new state and call a service for update.  In example below, an HTTP request arrives and we essentially convert the incoming User request object to our domain User object using builders.

```java
final String newEmail = request.getNewEmail();
final String newLastName = request.getNewLastName();
final User user = userService.getUserDetails();
final User updatedUser = user.toBuilder()
                             .email(newEmail)
                             .lastName(newLastName).build();
userService.updateUserDetails(updatedUser);
```

This can be further enhanced in spring framework by implementing converters, which we will not cover in this doc. For demonstration purpose an example implementation of a converter would look as follows.

```java

import org.springframework.core.convert.converter.Converter;

@Component 
public class UserConverter implements Converter<UserRequest, User> {

    private final UserService userService;
    
    public UserConverter(UserService userService) {
        this.userService = userService;
    }

    User convert(UserRequest userRequest) {
        final String newEmail = request.getNewEmail();
        final String newLastName = request.getNewLastName();
        final User user = userService.getUserDetails();
        return user.toBuilder().email(newEmail)
                   .lastName(newLastName).build();
    }
}
```


## Unit Tests

The following are snippets for Unit test methods for User and SuperUser classes. To automate our checks and guarantee business critical methods like _isSuperUser()_ to continue to work as expected, we would write tests for these classes. 

### UserTest

```java
@Test
void builder() {
    final User johnDoe = User.builder().firstName("John")
            .lastName("Doe")
            .build();
    assertThat(johnDoe.getFirstName()).as("FirstName")
            .isEqualTo("John");
    assertThat(johnDoe.getLastName()).as("LastName")
            .isEqualTo("Doe");
}

@Test
void builder_IsNotSuperUser() {
    final User johnDoe = User.builder().firstName("John")
            .build();
    assertThat(johnDoe.isSuperUser()).as("IsSuperUser")
            .isFalse();
}
```

Full User tests can be found in [UserTest](https://github.com/kapresoft/lombok/blob/887698214954e34b9016137547b30b9f83844082/src/test/java/com/kapresoft/lombok/builders/UserTest.java#L1).

### SuperUserTest

```java
@Test
void builder_IsSuperUser() {
    User superUser = SuperUser.builder()
            .firstName("John").lastName("Doe")
            .permission("canUpdate").permission("canDelete")
            .build();
    assertThat(superUser.isSuperUser())
            .isTrue();
}

@Test
void copyConstructor_ShouldHaveEqualFieldValues() {
    SuperUser johnDoe = SuperUser.builder()
            .email("johndoe@gmail.com")
            .permission("canUpdate").permission("canDelete")
            .build();
    SuperUser johnDoeCopy = johnDoe.toBuilder().build();
    assertThat(johnDoe).hasToString(johnDoeCopy.toString());
}
```

Full SuperUser tests can be found in [SuperUserTest](https://github.com/kapresoft/lombok/blob/887698214954e34b9016137547b30b9f83844082/src/test/java/com/kapresoft/lombok/builders/SuperUserTest.java#L1).


## Summary

For this article, the Lombok _@Builder_ annotation on a method was illustrated to create a builder and copy constructor via the default _builder()_ and  _toBuilder()_ methods on immutable objects. A few points are also mentioned how the caveats with implementing builder and copy constructors in plain java implementations may no longer apply when using Lombok.

The GitHub repository that this article references can be found in [https://github.com/kapresoft/lombok](https://github.com/kapresoft/lombok). Refer to the main documentation on the repository on how to build this project in your local environment.
