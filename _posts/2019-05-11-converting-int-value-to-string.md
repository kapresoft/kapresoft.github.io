---
layout: kapresoft
title: Converting int to a String in Java
image: /assets/images/kapresoft1-210x.png
canonical_url: https://www.kapresoft.com/java/2019/05/11/converting-int-value-to-string.html
category: java
---

# Overview

In Java, often times the ability to return a string representing the specified integer is a common task.  This article illustrates several mechanisms to convert int to a string in Java. In the opposite scenario, the means to resolve an integer representing the value of the specified String.  The returned value is an Integer object that is the equivalent integer value of the argument string.

<!--excerpt-->

# Integer.valueOf(val:int) : Integer

Creates a java.lang.Integer represented by the argument *val* of primitive int type.

```java
Integer number = Integer.valueOf(3);
System.out.println(number);
// Output: 3
```

# Integer.valueOf(val:String) : Integer

Creates a java.lang.Integer represented by the string argument *val*.

```java
Integer number = Integer.valueOf("4");
System.out.println(number);
// Output: 4
```

# Integer.toString(val:int) : String

Creates a string representation of the argument *val* of primitive int type.

```java
String numberString = Integer.toString(5)
System.out.println(numberString);
// Output: 5
```

# Integer.parseInt(val:String)
Creates a primitive int representation of the string argument *val*.

```java
int number = Integer.parseInt("6") : int
System.out.println(number)
// Output: 6
```

# String.valueOf(val:int) : String

Returns a java.lang.String representation with the value extracted from the primitive int *val*.

```java
String numberString = String.valueOf(7);
System.out.println(numberString)
// Output: 7
```

# Integer.getInteger(sysPropName:String) : Integer
Resolves a java.lang.Integer value of the given system property
*sysPropName*, otherwise returns a null.

Given a system property: *version.number*; an example system property could be passed via command line args:

```commandline
$ java -Dversion.number=1 <JavaClass>
```

A system property can be resolved via:
```java
Integer versionNumber = Integer.getInteger("version.number");
System.out.println(versionNumber);
// Output: 1
```

# Integer.getInteger(sysPropName:String, val:int) : Integer

Resolves a java.lang.Integer value of the given system property
*sysPropName* with the specified name with the fallback value
of *val*.

Given a system property:

```
version.number=2
```

```java
Integer versionNumber = Integer.getInteger("version.number", 0);
System.out.println(versionNumber);
// Output: 2
```

Without setting the system property *version.number*, the versionNumber variable is assigned the default value of zero (0).