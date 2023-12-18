---
title: "Lombok val vs var"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/10/18/java-lombok-val-vs-var.html
category: java
related: lombok
description: "Unlock the power of Lombok's val and var for concise Java code. Dive deep into type inference, configuration, and best practices."
---

## Overview

Lombok has gained immense popularity among Java developers for its ability to simplify coding practices by reducing boilerplate code. In the vast ocean of features offered by Lombok, two features stand out: _val_ and _var_. In this deep dive, we'll uncover the secrets of these two variables and demonstrate their utility.<!--excerpt-->

## Embracing Simplicity with Lombok

Before diving into the specifics of _val_ and _var_, it's crucial to appreciate Lombok's overarching goal. Lombok endeavors to make Java code more concise, readable, and less error-prone. By introducing annotations and inbuilt functions, Lombok eradicates the need for repetitive code, letting us focus on the core logic.

## Deciphering _val_ and _var_ in Lombok

### Lombok _val_: The Immutable Helper

Lombok introduced _val_ in its 0.10 version. Whenever we use _val_, Lombok assumes the variable to be _final_ and derives its type based on the initialization value. This means, once initialized, you cannot modify its value, ensuring immutability.

Here's a basic example:
```java
import lombok.val;

public Class greet() {
 val greeting = "Hello";
 System.out.println(greeting);
 return greeting.getClass();
}
```
Lombok translates this to:
```java
final String greeting = "Hello";
```

### Lombok _var_: The Flexible Companion

The _var_ variable was introduced in Lombok version 1.16.20. Similar to _val_, it deduces the type based on the initial value. However, unlike _val_, _var_ is not immutable, allowing further assignments as long as they adhere to the initially inferred type.

Example:
```java
import lombok.var;

var subject = "Java";
subject = "Lombok";
```
This capability is reminiscent of Java 10's type inference for local variables.

### Hands-on with _val_ and _var_

#### 1. Declaring Simple Types

By employing _val_, we can quickly declare simple data types such as Strings or Integers:
```java
val country = "USA";
val population = Integer.valueOf(331002651);
```
Lombok intelligently discerns the type:
```java
final String country = "USA";
final Integer population = Integer.valueOf(331002651);
```

#### 2. Working with Collections

Using Lombok, declaring collections like Lists and Maps becomes a breeze:
```java
val capitals = new ArrayList<String>();
capitals.add("Washington D.C.");
```
Lombok discerns the List and its content type:
```java
final List<String> capitals = new ArrayList<String>();
```

#### 3. Delving into Compound Types

There may be instances where the type inference depends on conditions. In such cases, Lombok determines the most common superclass.
```java
val collectionType = isQueue ? new LinkedList<String>() : new ArrayList<String>();
```
For the code above, Lombok would infer _List_ as the type since both _LinkedList_ and _ArrayList_ are implementations of the _List_ interface.

## In Conclusion

Lombok's _val_ and _var_ are powerful tools in a developer's toolkit. They promote clean, concise code, fostering enhanced readability and maintainability. While _val_ ensures immutability, _var_ offers flexibility, both aiding in writing robust Java applications.

As with any tool, the key lies in understanding its nuances and applying it judiciously. With this comprehensive guide, we hope the developer is well-equipped to leverage the might of Lombok in their Java projects.
