---
title: "Lombok • Using @With Annotation to Clone Immutable Objects"
canonical_url: https://www.kapresoft.com/java/2022/08/29/lombok-cloning-immutable-objects-using-with.html
image: /assets/images/kapresoft1-210x.png
category: java
description: "Using @With Annotation to Clone Immutable Objects"
---

## Overview

Using Lombok's [@With](https://projectlombok.org/features/With) Annotation to Clone Immutable Objects is a beneficial feature that helps developers minimize code replication and ceremonial code.  It is the next best alternative to Copy Constructs in object-oriented programming.  The _@With_ annotation also requires _@AllArgsConstructor_ to function correctly.

<!--excerpt-->

## Project

For rapid application development the maven project provided in this example used the spring initializr page [https://start.spring.io](https://start.spring.io) to generate the initial source code.

The source code referenced by this article can be found at [https://github.com/kapresoft/lombok-with](https://github.com/kapresoft/lombok-with).

## Use Case

In this simple example, we will model a resident of a house.  The _Resident_ class can be modeled in Lombok as:

```java
@Value @Builder
public class Resident {

    @With
    String fullName;
    @With
    String phoneNumber;
    String streetAddress;
    String city;
    String state;
    String zipCode;
    String country;

}
```
Source: [Resident.java](https://github.com/kapresoft/lombok-with/blob/master/src/main/java/com/kapresoft/lombok/builders/Resident.java)

In order to utilize the power _@With_ annotation, you must use it in conjunction with _@AllArgsConstructor_. In the above class definition, _@Value_ is used.  The _@Value_ is a simplification for configuring a class with immutable fields. 

The _@Value_ annotation can be similarly modeled by _@Getter_ and final fields and other annotations as shown below:

```java@Getter 
@FieldDefaults(makeFinal=true, level=AccessLevel.PRIVATE) 
@AllArgsConstructor 
@ToString 
@EqualsAndHashCode
public class Resident {
    @Getter @With
    private final String fullName;
    // ... etc
}
``` 

Please Refer to [Lombok • Builders and Copy Constructors](/java/2021/12/27/lombok-builders-and-copy-constructors.html) for more details on immutable objects in Lombok.

A few thing worth mentioning is that you must adhere to Lombok's class field naming convention. Static fields are not supported by _@With_ and _$_ symbols are ignored.

A single resident can then be created and verified as:

```java
@Test
void createSingleResident() {
    final Resident johnDoe = Resident.builder()
            .streetAddress("100 Main St")
            .city("Bellevue").state("WA")
            .fullName("John Doe")
            .phoneNumber("425-555-1000")
            .city("Bellevue").state("WA").zipCode("98004")
            .build();
    assertThat(johnDoe.getFullName()).as("Full Name")
            .isEqualTo("John Doe");
    assertThat(johnDoe.getPhoneNumber()).as("Phone Number")
            .isEqualTo("425-555-1000");
    assertThat(johnDoe.getCity()).as("City")
            .isEqualTo("Bellevue");
    assertThat(johnDoe.getState()).as("State")
            .isEqualTo("WA");
    assertThat(johnDoe.getState()).as("ZipCode")
            .isEqualTo("98004");
}
```
Source: [ResidentTest.java](https://github.com/kapresoft/lombok-with/blob/master/src/test/java/com/kapresoft/lombok/builders/ResidentTest.java)

Suppose there are two other residents.  Those additional residents can be cloned from the existing immutable instance _johnDoe_.  A newly created clone and immutable Resident objects _janeDoe_ and _teenageDaughter_ with a slightly different information modified by `withFullName(String)` and `withPhoneNumber(String)` methods.

```java
@Test
void createResidents() {
    final Resident johnDoe = Resident.builder()
            .streetAddress("100 Main St")
            .city("Bellevue").state("WA")
            .fullName("John Doe")
            .phoneNumber("425-555-1000")
            .city("Bellevue").state("WA").zipCode("98004")
            .build();
    assertThat(johnDoe.getFullName()).as("Full Name")
            .isEqualTo("John Doe");
    assertThat(johnDoe.getPhoneNumber()).as("Phone Number")
            .isEqualTo("425-555-1000");

    final Resident janeDoe = johnDoe
            .withFullName("Jane Doe")
            .withPhoneNumber("425-555-1001");
    assertThat(janeDoe.getFullName()).as("Full Name")
            .isEqualTo("Jane Doe");
    assertThat(janeDoe.getPhoneNumber()).as("Phone Number")
            .isEqualTo("425-555-1001");

    final Resident teenageDaughter = johnDoe.withFullName("Jennifer Doe")
            .withPhoneNumber("425-555-1002");
    assertThat(teenageDaughter.getFullName()).as("Full Name")
            .isEqualTo("Jennifer Doe");
    assertThat(teenageDaughter.getPhoneNumber()).as("Phone Number")
            .isEqualTo("425-555-1002");

}
```
Source: [ResidentTest.java](https://github.com/kapresoft/lombok-with/blob/master/src/test/java/com/kapresoft/lombok/builders/ResidentTest.java)

### Class, Field and Access Level Configuration

The _@With_ annotation is a class or field-level annotation. 

#### Class Level
In the main example, the _@With_ was placed at the field-level. In this example, a class-level _@With_ annotation means that a 'with' method is generated for each and every field.

```java
@Value @Builder @With
public class Resident {

    String fullName;
    String phoneNumber;
    String streetAddress;
    String city;
    String state;
    String zipCode;
    String country;

}
```

```java

final Resident johnDoe = Resident.builder()
            .streetAddress("100 Main St")
            .city("Bellevue").state("WA")
            .fullName("John Doe")
            .phoneNumber("425-555-1000")
            .city("Bellevue").state("WA").zipCode("98004")
            .build();

final Resident janeDoe = johnDoe
        .withFullName("Jane Doe")
        .withPhoneNumber("425-555-1001")
        .withStreetAddress("100 Rodeo Drive")
        .withCity("Beverly Hills")
        .withState("CA")
        .withZipCode("90210");

```

#### Access Level

The _@With_ may also be configured with an access level:

```java
@With(value = AccessLevel.PACKAGE)
String fullName;
```

The above configuration will produce a method:
```java
Resident withFullName(String fullName) {
        // ... function body here ...
}
```


## Summary
This article covered how to use Lombok's _@With_ annotation at a class and field level; an example use-case to generate clones of immutable objects with a change in multiple fields. We also covered configuring the method access level (private, protected, public, or package-level) of the generated "with" methods in Lombok.

Full code examples are available at Github [https://github.com/kapresoft/lombok-with](https://github.com/kapresoft/lombok-with).

## Suggested Reading

- [Lombok • Builders and Copy Constructors](/java/2021/12/27/lombok-builders-and-copy-constructors.html)