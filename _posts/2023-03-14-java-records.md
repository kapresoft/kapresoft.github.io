---
title: Java Records
canonical_url: https://www.kapresoft.com/java/2023/03/14/java-records.html
category: java
related: java
description: "Java record is a concise feature for creating data storage classes. Introduced in Java 14, it primarily consists of fields and getters."

---

## Overview

A Java record is a new feature introduced in Java 14 that allows developers to create a class that is primarily used to store data. A record is essentially a concise way to define a class that consists mainly of state (fields) and accessors (getters).
<!--excerpt-->

## Supported Java Versions

Record types were introduced in Java 14 and are supported in subsequent versions of Java, including Java 15, Java 16, and later versions. If you want to use records in your Java code, you'll need to use a version of Java that supports them.

To check the version of Java installed on your machine, you can open a command prompt or terminal window and type java -version. This will display the version of Java that is currently installed on your machine. If your version of Java is older than Java 14, you will need to upgrade to a newer version in order to use records.

## Definition

To define a record, you use the record keyword followed by the name of the class and a list of its components (fields). For example:


```java
public record Person(String name, int age) {}
```

This record defines a class named Person with two components: a String field named name and an int field named age. The record keyword generates a constructor, accessors (getters), and equals(), hashCode(), and toString() methods automatically.

Records are immutable by default, meaning that their state cannot be changed after they are created. However, you can define mutable records by using the var keyword in front of the components that need to be mutable.

Records can be useful for representing data objects, such as entities in a database or values returned from an API. They can make code more concise and easier to read and write.

## Use Cases

Java records are primarily designed to simplify the creation and usage of classes that are used primarily for storing data. Here are some common use cases for Java records:

1. Data Transfer Objects (DTOs): Java records can be used to define DTOs, which are used to transfer data between different layers of an application, such as from a database to a user interface.

1. Value Objects: Records can be used to define value objects, which are immutable objects that represent a value or concept, such as a point in a 2D coordinate system or a color.

1. JSON or XML data parsing: Records can be used to simplify the process of parsing JSON or XML data into Java objects. With the automatically generated constructor and accessors, developers can easily map the incoming data to a record instance.

1. API responses: Records can be used to represent API responses or data returned from a service. This can simplify the code needed to parse and handle the response, as the record provides an easy-to-use data structure.

1. Configuration Objects: Records can be used to define configuration objects that store application settings, such as the size of a thread pool or the maximum number of database connections.

Overall, Java records can be useful in any scenario where you need to create classes that are primarily used to store data and do not require a lot of behavior or logic. By providing a concise and easy-to-use syntax, Java records can simplify the code required to define and use these classes.

### Value Object Example Using a Record

Here's an example of using Java records to define a value object:

```java
public record Point(int x, int y) {
    public Point {
        if (x < 0 || y < 0) {
            throw new IllegalArgumentException("Invalid point coordinates");
        }
    }
}
```

In this example, we're defining a _Point_ class that represents a point in a 2D coordinate system. The record has two components: _x_ and _y_, which represent the coordinates of the point. We're also defining a constructor that checks that the coordinates are valid (i.e., they're not negative).

Since records are immutable by default, the _x_ and _y_ components are automatically made _final_. We can create a new Point object like this:

```java
Point p = new Point(10, 20);
```

Since the _x_ and _y_ components are public, we can access them directly:

```java
System.out.println("x: " + p.x()); // prints "x: 10"
System.out.println("y: " + p.y()); // prints "y: 20"
```

Since records automatically generate an _equals()_ method, we can use it to compare two Point objects:

```java
Point p1 = new Point(10, 20);
Point p2 = new Point(10, 20);
System.out.println(p1.equals(p2)); // prints "true"
```

Overall, using a record to define a value object like _Point_ can simplify the code required to create and use these objects, since the record provides a concise and easy-to-use syntax.

## In Conclusion

In this article, we talked about Java records and their use cases. Java records are a new feature introduced in Java 14 that allow developers to create classes that are primarily used to store data. Records provide a concise syntax for defining these classes and automatically generate a constructor, accessors (getters), and _equals()_, _hashCode()_, and _toString()_ methods.

We discussed some common use cases for Java records, including data transfer objects (DTOs), value objects, JSON or XML data parsing, API responses, and configuration objects. We also looked at an example of using a record to define a value object representing a point in a 2D coordinate system.

Overall, Java records can be a useful tool for simplifying the code required to define and use classes that are used primarily for storing data. By providing a concise syntax and automatically generating commonly used methods, records can help make code more readable and easier to write.
