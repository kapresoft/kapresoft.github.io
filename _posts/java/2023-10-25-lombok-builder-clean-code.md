---
title: "Cleaner Code and Enhanced Testability: Harnessing the Power of Lombok Builders"
title_style: title2
canonical_url: https://www.kapresoft.com/java/2023/10/25/lombok-builder-clean-code.html
category: java
related: lombok
description: "Unlock the potential of your Java applications by leveraging Project Lombok's builders to write cleaner, more testable code with less boilerplate."
---

## Overview

In the realm of Java development, the quest for cleaner code and improved testability is ever-present. One formidable ally in this quest is Project Lombok, a mature library that revolutionizes the way Java developers handle boilerplate code.<!--excerpt--> This article aims to showcase the transformative power of Lombok builders in enhancing code cleanliness and testability.

## Understanding Boilerplate Code in Java
Boilerplate code refers to the redundant and unnecessary code that developers often find themselves writing, especially when dealing with Java objects. This includes the prolific getter and setter methods that are common in Java classes. These methods, while essential for accessing and modifying private fields, contribute significantly to the clutter in your codebase.

## Introducing Project Lombok
Project Lombok is a powerful and easy-to-use library that significantly reduces boilerplate code through its annotations. By utilizing Lombok, Java developers can streamline their code and focus more on the application's core logic rather than being bogged down by repetitive and tedious coding tasks.

## Case Study: The Person Class

Let's examine an example of a _Person_ class that has been expanded to include four additional fields: email, address, phoneNumber, and occupation.

### Without Lombok:
```java
public class Person {
    private String name;
    private int age;
    private String email;
    private String address;
    private String phoneNumber;
    private String occupation;

    public Person(String name, int age, String email, String address, String phoneNumber, String occupation) {
        this.name = name;
        this.age = age;
        this.email = email;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.occupation = occupation;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    // Additional methods like equals() and hashCode()
}
```

In the given example, the Person class is encumbered with the ceremonial inclusion of getter and setter methods for each field. Although IDEs like IntelliJ or Eclipse offer generators for these methods, the resulting code is often not visually appealing or clean to the eye. 

Additional methods like _equals()_ and _hashCode()_ will further increase the size of this class, making it even larger and harder to manage. 

The essential yet bulky getter and setter methods contribute significantly to the boilerplate code, rendering the class verbose and cumbersome to maintain. Additionally, the constructor's demand for six parameters introduces a layer of complexity that can muddle test cases, leaving developers to grapple with the intricacies of parameter order and significance.

### With Lombok:
```java
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.RequiredArgsConstructor;

@Getter
@Setter
@RequiredArgsConstructor
public class Person {
    private final String name;
    private final int age;
    private final String email;
    private final String address;
    private final String phoneNumber;
    private final String occupation;
}
```

The difference is striking. The Lombok-annotated class is succinct, with the _@Getter_ and _@Setter_ annotations taking care of the accessor methods, and the _@RequiredArgsConstructor_ annotation creating the constructor for us. This is a prime example of how Lombok tackles boilerplate code head-on.

## The Power of Lombok Builders in Unit Tests
When it comes to testing Java applications, the construction of objects for test cases can often lead to cluttered and hard-to-read code. Lombok builders come to the rescue by providing a clean and straightforward way to construct objects.

### Unit Test without Lombok Builder:

When we look at the constructor in the example provided, it's clear to see how it can become unwieldy as the number of fields grows. With six parameters already required to create a _Person_ object, the constructor is sizable and could lead to potential confusion or errors when instantiating objects, particularly as more fields are added.

```java
import org.junit.jupiter.api.Test;

public class PersonTest {
    @Test
    public void testPerson() {
        Person person = new Person("John Doe", 30, "john.doe@example.com", "123 Main St", "123-456-7890", "Software Engineer");
        // Perform test assertions...
    }
}
```

When a new developer comes to this code at a later date, it won't be straightforward for them to decipher the significance and order of each parameter in the constructor. 

As the number of fields grows, the constructor becomes increasingly unwieldy, with six parameters already required to create a _Person_ object. 

This sizeable constructor could lead to potential confusion or errors when instantiating objects, especially as more fields are added.

#### Updates to the constructor

Another case in point is that when a new field is added to an existing object, it often necessitates a change in the constructor, especially if the new field should appear in the middle of the parameter list. This can result in unclear compiler errors, leaving the developer to grapple with rectifying the situation.

Consider the following scenario where a field _height_ is added and the position of the constructor is after _age_.

Before the new field is added:
```java
public class Person {
    private String name;
    private int age;
    private int height; // new
    private String email;
    private String address;
    private String phoneNumber;
    private String occupation;

    public Person(String name, int age, 
                  int height, // new 
                  String email, 
                  String address, 
                  String phoneNumber, 
                  String occupation) {
        this.name = name;
        this.age = age;
        this.height = height; // new
        this.email = email;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.occupation = occupation;
    }
}
```

In this case, any pre-existing code that uses the old constructor **will now report a compiler error because the number and type of parameters in the constructor call no longer match the updated constructor**. The developer is then forced to hunt down each instance of the old constructor and update it to include the new _height_ parameter, which can be time-consuming and error-prone.


### Unit Test with Lombok Builder:

#### The Transformative Power of Lombok Builders
When it comes to testing Java applications, the construction of objects for test cases can often lead to complex and hard-to-read code. This complexity is magnified as the number of fields in the object increases, resulting in convoluted and confusing test cases that can be difficult to manage and maintain. Lombok builders provide a solution to this problem, offering a clean and straightforward way to construct objects.

Here is the updated _Person_ class with the _@Builder_ annotation for use in the unit test example:

```java
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.RequiredArgsConstructor;

@Getter
@Setter
@RequiredArgsConstructor
@Builder
public class Person {
    private final String name;
    private final int age;
    private final String email;
    private final String address;
    private final String phoneNumber;
    private final String occupation;
}
```

```java
import lombok.Builder;
import org.junit.jupiter.api.Test;

public class PersonTest {
    @Test
    public void testPerson() {
        Person person = Person.builder()
                .name("John Doe")
                .age(30)
                .email("john.doe@example.com")
                .address("123 Main St")
                .phoneNumber("123-456-7890")
                .occupation("Software Engineer")
                .build();
        // Perform test assertions...
    }
}
```

The Lombok builder offers a fluid and intuitive way to create objects, enhancing the readability of your test code. By chaining setter methods, you can construct an object in a way that mirrors how you would describe it in natural language, thereby making your test cases more understandable and maintainable.

#### Updates to the Constructor

On the contrary, when we utilize Lombok's builder annotation, the process of adding new fields becomes seamless and stress-free. **Adding a new field or reordering existing fields in the constructor will not affect existing code.** This applies not only to Lombok but to any implementation of the builder pattern, showcasing its robustness in handling changes and maintaining code consistency.

Let's consider the updated _Person_ class with the additional _height_ field, now employing a builder:

```java
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Person {
    private final String name;
    private final int age;
    private double height;
    private final String email;
    private final String address;
    private final String phoneNumber;
    private final String occupation;
}
```

When we create a _Person_ object in our unit test using the Lombok builder, it becomes strikingly straightforward:

```java
import org.junit.jupiter.api.Test;

public class PersonTest {
    @Test
    public void testPerson() {
        Person person = Person.builder()
                .name("John Doe")
                .age(30)
                .height(5.9) // add anywhere in the method chain
                .email("john.doe@example.com")
                .address("123 Main St")
                .phoneNumber("123-456-7890")
                .occupation("Software Engineer")
                .build();
        // Update test assertions asserting the new "height" field 
    }
}
```

In this case, the addition of the new _height_ field does not disrupt our existing unit tests. While the existing unit test code will be out of date, it will not be broken since the developer used builders to construct the object. No compiler errors are thrown, and developers are not forced to hunt down and update each instance of object creation. The code remains clean, readable, and easy to maintain, demonstrating the clear advantage of using Lombok builders in enhancing testability and overall code quality.


## Conclusion

Project Lombok's builders are a crucial tool for any Java developer seeking to write cleaner, more maintainable code with improved testability. The way Lombok effortlessly handles boilerplate code, combined with its builder functionality, makes it a must-have in a Java developer's toolkit. Embrace the transformative power of Lombok and elevate your code to new heights of clarity and elegance.
