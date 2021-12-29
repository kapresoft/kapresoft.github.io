---
title: Converting double to a String in Java
image: /assets/images/kapresoft1-210x.png
canonical_url: https://www.kapresoft.com/java/2019/05/11/converting-double-value-to-string.html
category: java
desription: "Convert double to a string value in java"
---

# Overview

Converting double to a String value in Java has been a typical task to do for software development. This article discusses the various ways on how to convert a double to a string in Java. While there are advantages in representing a double to its String object representation, the opposite task of converting a String object to a double can also be addressed.  This document examines the reasons why conversions of double in Java are beneficial for beginners who are learning to develop in java.

<!--excerpt-->

# Double.parseDouble(val : String) : double

Creates a primitive double representation of the string argument *val*.

```java
double rating = Double.parseDouble("5.0");
System.out.println(rating);
// Output: 5.0
```

# Double.valueOf(val : double) : Double

Creates a java.lang.Double object represented by the primitive double argument *val*.

```java
Double average = Double.valueOf(95.9);
System.out.println(average);
//Output: 95.9
```

# Double.valueOf(val : String) : Double

Creates a java.lang.Double object represented by the string argument *val*

```java
Double balance = Double.valueOf(1000.01);
System.out.println(balance);
//Output: 1000.01
```

# String.valueOf(val:double) : String

Creates a java.lang.String represented by the value of the double argument *val*.

```java
Double hoursLeft = Double.valueOf("2.5");
System.out.println(hoursLeft);
//Output: 2.5
```

# Double.toString(val:double) : String

Creates a java.lang.String represented by the double value argument *val*.

```java
Double inchesOfSnow = Double.toString(10.5);
System.out.println(inchesOfSnow);
//Output: 10.5
```

