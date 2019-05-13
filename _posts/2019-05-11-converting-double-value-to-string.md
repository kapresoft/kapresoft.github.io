---
layout: kapresoft
title: Converting double to a String
image: /assets/images/kapresoft.png
canonical_url: https://www.kapresoft.com/java/2019/05/11/converting-double-value-to-string.html
category: java
---

# Overview

This article discusses the various ways to convert double to a string in Java.

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

