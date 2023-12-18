---
title: "Java Modern Collection Utilities"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/11/06/java-modern-collection-utilities.html
category: java
related: java
description: "Discover the power of Java's modern collection java.util.Collecdtions and List.of(), Map.of(), Set.of()"
---

## Overview

Java's evolution has always been about simplifying complexity and enhancing efficiency. The collection utilities have undergone significant improvements since JDK 8, transitioning from the _Collections_ utility class to the intuitive _List.of()_, _Map.of()_, and _Set.of()_ methods.<!--excerpt--> This article delves deep into the intricacies of these utilities, offering a comparative guide bolstered by performance analysis, use cases, and best practices.

## The Legacy Approach: Collections in JDK8

Before JDK 9, creating immutable collections was a verbose process, typically involving the _Collections_ class. Here’s how it was typically done:

```java
List<String> modifiableList = new ArrayList<>();
modifiableList.add("Java 8");
modifiableList.add("Collections");
List<String> unmodifiableList = Collections.unmodifiableList(modifiableList);
```

This approach was functional but not without its shortcomings. It was verbose, prone to errors, and potentially inefficient.

## Transition to Modernity: The Advent of List.of(), Map.of(), and Set.of()

JDK 9 introduced methods that streamline immutable collection creation:

### List.of() in Action

```java
List<String> immutableList = List.of("Java 9", "Collections", "Efficiency");
```

This simple, single-line approach provides immediate readability improvements and other substantial benefits.

## Performance Analysis: Old vs. New

When it comes to performance, the modern methods outshine their predecessors. Immutable collections created with _List.of()_, _Map.of()_, and _Set.of()_ are more memory-efficient due to their internal data structures optimized for unmodifiable collections.

#### Memory Consumption and Access Times

Consider the following hypothetical benchmark results:

- JDK 8 _Collections.unmodifiableList()_: Memory footprint of X MB and access time of Y ms
- JDK 9 _List.of()_: Memory footprint of (X-10)% MB and access time of (Y-50)% ms

Such results, while illustrative, point towards the enhanced performance and lower overhead of the modern utilities.

## Use Cases and Best Practices

When leveraging Java's modern collection utilities, it's crucial to understand not only their syntax but also the scenarios in which they excel. Properly integrating these utilities into your development workflow can lead to more readable, efficient, and maintainable code. This section explores various use cases for immutable collections provided by methods like _List.of()_, _Set.of()_, and _Map.of()_, and shares best practices for their effective use.

Whether you're dealing with constant configurations, needing to ensure thread safety, or simply wanting to reduce the verbosity of your code, these modern utilities can significantly enhance your Java applications. We will delve into specific instances that demonstrate the strengths of immutable collections and provide guidelines to ensure you are using them in ways that align with Java's best practices.

### Ideal Scenarios for Immutable Collections

#### Concurrent Environments

Immutable collections are inherently thread-safe, suitable for scenarios where data is shared across multiple threads. The immutability guarantees that the state of the collection won't change after its creation, eliminating the risks of concurrent modifications. Let's look at an example of immutable collections in a concurrent application:

```java
// Define a set of system roles that will not change throughout the application
Set<String> systemRoles = Set.of("ADMIN", "USER", "GUEST");

// Thread A: Read from the set
Thread threadA = new Thread(() -> {
    if (systemRoles.contains("ADMIN")) {
        System.out.println("Thread A: 'ADMIN' role exists.");
    }
});

// Thread B: Read from the set
Thread threadB = new Thread(() -> {
    if (systemRoles.contains("USER")) {
        System.out.println("Thread B: 'USER' role exists.");
    }
});

// Start the threads
threadA.start();
threadB.start();
```

Since _systemRoles_ is immutable, there is no risk of one thread modifying the collection while another is iterating over it, which prevents concurrency-related issues like _ConcurrentModificationException_.

#### Constant Data Sets

Immutable collections are ideal for representing data sets that do not change, ensuring consistent and reliable application behavior. This stability is particularly valuable for fixed configuration values. Below is an example of their use:

```java
// Application configuration settings
Map<String, String> configSettings = Map.of(
    "MAX_LOGIN_ATTEMPTS", "5",
    "SESSION_TIMEOUT", "30",
    "DEFAULT_LANGUAGE", "en"
);

// Usage throughout the application
public void checkLoginAttempts(String username) {
    int maxAttempts = Integer.parseInt(configSettings.get("MAX_LOGIN_ATTEMPTS"));
    // ... rest of the code to check login attempts
}

// Somewhere else in the application
public void endUserSession() {
    int timeout = Integer.parseInt(configSettings.get("SESSION_TIMEOUT"));
    // ... rest of the code to handle session timeout
}
```

Using _Map.of()_ here ensures that the configuration settings cannot be altered at runtime, which enforces consistency and reduces the chance of accidental or unauthorized changes to critical application settings.

### Best Practice: Combining Collections with Streams

```java
var evenNumbers = Stream.iterate(0, n -> n + 2)
                        .limit(10)
                        .collect(Collectors.toUnmodifiableList());
```

Here, we combine the power of streams with the immutability of collections.

## Code Migration and Compatibility

Migrating to modern collection utilities should be a careful process. For instance, while _List.of()_ is elegant, it disallows _null_ elements, which were permitted in _Collections.unmodifiableList()_.
    
#### Strategy for Migration

1. Identify collections that are candidates for immutability.
2. Replace instances of _Collections.unmodifiableList()_ with _List.of()_, taking care to handle _null_ values appropriately, as they are not permitted in the latter.
3. Test extensively to ensure that existing functionalities are not broken by the immutability constraints. All existing tests should pass.
4. Add additional tests post-migration to validate new implementations and to ensure that immutability does not inadvertently affect application logic.

## Behind the Scenes: The Immutable Collections API

When it comes to modernizing Java code, understanding what goes on behind the scenes with immutable collections is pivotal. Here are some additional insights into the API:

#### Ease of Discovery

The new utility methods for creating immutable collections are intuitively located directly within the interface of the collection they create. For instance, _List.of()_ is found within the _List_ interface and similarly, _Map.of()_ is in the _Map_ interface. This direct association makes it easier for developers to remember and use the appropriate methods without confusion.

  Example for Lists:
  ```java
  // Creating an immutable list with JDK 9+ utility method
  List<String> petBreeds = List.of("French Bulldog", "Pug", "Chihuahua");
  ```

  Example for Maps:
  ```java
  // Creating an immutable map with JDK 9+ utility method
  Map<Integer, String> numberMapping = Map.of(1, "One", 2, "Two", 3, "Three");
  ```

#### Varargs Advantage

The newer utility methods like _List.of(...)_ and _Set.of(...)_ make use of varargs, allowing developers to include an arbitrary number of elements in a collection in a single line, enhancing readability and reducing boilerplate code as compared to their _Collections_ counterparts.

  Example using _List.of_ with varargs:
  ```java
  // JDK 9+ way of creating an immutable list with multiple elements
  List<String> colorList = List.of("Red", "Green", "Blue", "Yellow", "Pink");
  ```

  Example comparing to _Collections.unmodifiableList_:
  ```java
  // Old way: Creation of an immutable list before JDK 9
  List<String> tempColorList = new ArrayList<>();
  tempColorList.add("Red");
  tempColorList.add("Green");
  tempColorList.add("Blue");
  tempColorList.add("Yellow");
  tempColorList.add("Pink");
  List<String> oldImmutableColorList = Collections.unmodifiableList(tempColorList);
  ```

The use of varargs simplifies the process of creating collections with multiple elements, eliminating the need for intermediate mutable collections or verbose array initialization. This streamlined approach reduces the likelihood of errors and aligns with modern Java's emphasis on expressiveness and conciseness.

## Comparison with Other Programming Languages

The concept of immutable collections is not exclusive to Java; it is a common feature found in many modern programming languages, each with its own implementation nuances.

Kotlin, for instance, has first-class support for immutable collections through its standard library. The function _listOf()_ in Kotlin is directly used to create an immutable list, which is similar in spirit to Java’s _List.of()_ method introduced in later versions.

Here's how you would create an immutable list in Kotlin:

```kotlin
// Kotlin: Creating an immutable list using listOf
val colors = listOf("Red", "Green", "Blue")
```

This compares to Java’s approach:

```java
// Java: Creating an immutable list using List.of
List<String> colors = List.of("Red", "Green", "Blue");
```

Both Kotlin and Java's approaches ensure that once a list is created, it cannot be modified, enforcing a level of safety and predictability in the code.

Similarly, other languages have their conventions and utilities for immutable collections. For example, in Scala, you have an entirely separate hierarchy for immutable collections, and you can create an immutable list using:

```scala
// Scala: Creating an immutable list
val numbers = List(1, 2, 3)
```

The consistency of using collection interfaces to create immutable instances simplifies the developer experience across different languages and promotes the use of immutable data structures for more robust and maintainable code.

## Advanced Tips and Tricks

To further refine your use of Java's modern collection utilities, you can incorporate these methods into custom utility classes or wrappers. These can provide extended functionality, such as additional validation rules or tailored behaviors, to meet the specific needs of your application.

Here's an example of a custom utility class that wraps a _List.of()_ call to ensure all strings passed to it comply with a certain format:

```java
public class CustomStringList {

    public static List<String> ofValidatedStrings(String... elements) {
        for (String element : elements) {
            if (!isValidFormat(element)) {
                throw new IllegalArgumentException("Invalid string format: " + element);
            }
        }
        return List.of(elements);
    }

    private static boolean isValidFormat(String string) {
        // Dummy format validation
        return string.matches("^[a-zA-Z0-9]*$");
    }
}
```

Usage:

```java
List<String> validStrings = CustomStringList.ofValidatedStrings("Alpha123", "Beta456");
```

## Limitations and Considerations

While the methods _List.of()_, _Set.of()_, and _Map.of()_ introduced in JDK 9 offer concise syntax and immutability, there are some limitations that you should consider:

- **Fixed-size**: Once created, the size of these collections cannot be changed. Attempting to add or remove elements will throw an _UnsupportedOperationException_.

Example of fixed-size limitation:

```java
List<String> immutableList = List.of("One", "Two", "Three");
// The below operation will throw UnsupportedOperationException
immutableList.add("Four");
```

- **No null values**: _null_ is not a permitted value in any of these collections. If you attempt to create a collection with a _null_ value, a _NullPointerException_ will be thrown.

Example of _null_ value limitation:

```java
// The below operation will throw NullPointerException
List<String> immutableListWithNull = List.of("One", "Two", null);
```

Understanding these constraints is crucial when deciding to use these methods in your application to avoid unexpected runtime exceptions.

I apologize for the oversight. Here are the rewrites incorporating the new content for each of the provided questions:

## Frequently Asked Questions

### Q: What is the utility of Java Collections?
A: Java Collections Framework provides a set of classes and interfaces for storing and manipulating groups of data as a single unit, with operations for adding, removing, and querying elements.

### Q: What role does the collection interface play in Java?
A: The _Collection_ interface is the foundation of the Java Collections Framework. It establishes a contract for manipulating sets of objects, including basic operations like adding and removing elements, checking size, and iteration.

### Q: Can you explain what Java Util collections are in Java?
A: _java.util.Collections_ is a utility class filled with static methods designed for operating on objects of classes that implement the Collection interface. It provides methods for sorting, reversing, shuffling, and converting collections to thread-safe or unmodifiable versions.

### Q: How do Java Util collection and collections differ?
A: _java.util.Collection_ is an interface that outlines methods for a group of objects. _java.util.Collections_ is a utility class with static methods to perform common operations on collections, like sorting and searching.

### Q: Which Java collections methods are frequently used?
A: Commonly used methods in Java collections include _add()_, _remove()_, _contains()_, _size()_, and _iterator()_ for collections manipulation; and _sort()_ and _synchronizedCollection()_ from _java.util.Collections_ for collections sorting and thread safety.

### Q: What is the purpose of the Java Util library?
A: The Java Util library offers a comprehensive suite of ready-to-use data structures, algorithms, and utilities like date and time functions, random number generators, and string parsers, which are integral to Java programming.

### Q: Is it possible to append elements to a List instantiated via List.of()?
A: No, you cannot append elements to a List created with _List.of()_ because it is immutable. Any attempt to modify it will result in an _UnsupportedOperationException_.

### Q: Is there a workaround to append elements to a List created with List.of()?

A: While you cannot directly append elements to an immutable List created with _List.of()_, you can create a new List by combining the existing one with additional elements. This can be achieved by using the Stream API or by creating a new mutable list. Here are two ways to do it:

**Using Stream API:**
```java
List<String> originalList = List.of("a", "b", "c");
List<String> newList = Stream.concat(originalList.stream(), Stream.of("d", "e"))
                             .collect(Collectors.toList());
```

**Creating a new ArrayList:**
```java
List<String> originalList = List.of("a", "b", "c");
List<String> newList = new ArrayList<>(originalList);
newList.add("d");
newList.add("e");
// Now newList is a mutable list with the new elements appended.
```

Both methods create a new List that includes the elements from the original immutable List plus the new elements, effectively providing a workaround to the immutability constraint.

### Q: What is the method to create a Set with a large number of elements using Set.of()?
A: You can create a Set with more than 10 elements using the _Set.of(E... elements)_ method, which employs varargs to accept any number of elements, thereby allowing the creation of a large immutable set.

## Future of Collections in Java

The future may introduce collections that are even more performance-oriented, with features like value-based classes in Project Valhalla potentially impacting how collections are handled in Java.

## Concluding Thoughts on Modern Collection Utilities

The evolution of collection utilities in Java from JDK 8 to the latest versions marks a significant improvement in both the language's expressiveness and the safety of collection operations. The introduction of immutable collection factories such as _List.of()_, _Set.of()_, and _Map.of()_ provides Java developers with tools to create collections that are not just easier to write and read, but also less prone to common mistakes associated with mutability.

By eliminating the boilerplate code required to make unmodifiable collections and providing a clear, functional approach, these modern utilities encourage developers to write cleaner, more efficient code. The assurances of thread-safety and the guarantee against accidental modification mean that codebases can be more stable and predictable, a crucial aspect for modern applications dealing with concurrency and multi-threading.

Moreover, the ease of creating immutable collections aligns Java with other modern programming languages that prioritize immutability, making the transition between languages smoother for developers and enhancing Java's competitiveness.

It is important, however, for developers to remain mindful of the limitations and considerations when utilizing these modern utilities. Understanding when and how to use these immutable collections is key to harnessing their full potential, while also maintaining the integrity and performance of the application.

In conclusion, Java's modern collection utilities represent a step forward in the language’s continuous evolution, offering an elegant, robust, and safer way to work with collections. As with any feature, their power is best harnessed with a thorough understanding of their properties and appropriate use cases.
