---
title: "Java Optional - Why Developers Prefer Optional Values | Kapresoft"
image: /assets/images/kapresoft1-210x.png
canonical_url: https://www.kapresoft.com/java/2019/05/12/using-java-optional.html
category: java
description: "Discover why Java developers prefer Optional class over null for optional values. Explore the benefits and use cases in this in-depth article"
---

## Overview

This article discusses the use of **Java** **Optional** to introduce optional values instead of null. We will deep dive into understanding why developers prefer the Optional class to clearly communicate an optional value as opposed to a vague null representation of a variable.

<!--excerpt-->

This article will also illustrate the use of the functional interface in java.util.Optional to simply and reduce if-else logic in your code.  In Java 8, an [java.util.Optional](https://docs.oracle.com/javase/8/docs/api/java/util/Optional.html) class was introduced to treat such values at the type level to steer developers away from null-based programming.  When it comes to null-safety in java, often times we are forced to write defensive code.  Null checks in code has been around since the beginning. Others might argue that having a null is not the best way to represent whether a value is present or absent. Some may say that having an Optional class type will make the code a lot easier to read. Often times the source of several problems is the null reference to an object.  When null is used to indicate the absence of a value, many can encounter the dangers of null.

```java
String version = application.getFeature().getVersion();
String attrValue = application.getFeature().getAttributes().get("attr1");
```

The code above looks fairly reasonable.  The issue occurs when the a feature is not available and a common practice is to return a null reference to represent an absence of a particular feature. The call to __getVersion()__ will try to return a null reference, which will result in a __java.lang.NullPointerException__ at runtime and stop your code from running.

```java
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

public class MyApplication {
    
    public Optional<Feature> feature;

    public Optional<Feature> getFeature() {
        return feature;
    }

    public static class Feature {
        
        public String version;
        public Optional<Map<String, String>> attributes = Optional.of(new HashMap<>());

        public String getVersion() {
            return version;
        }

        public Optional<Map<String, String>> getAttributes() {
            return attributes;
        }
        
    }
    
}
```

The code can now be written as:

```java
Optional<MyApplication> app = loader.loadApplication(MyApplication.class);

String version = app.flatMap(MyApplication::getFeature)
                    .map(Feature::getVersion)
                    .orElse("NO VERSION");
```

## Optional.ofNullable(val:Object)

Creates an Optional instance of the supplied argument where the *val* could be absent (or not present).

```java
String firstName = null;
System.out.println(Optional.ofNullable(firstName).isPresent());
// Output: false
```

## Optional.of(val:Object)

Creates an Optional instance of the passed argument where the *val* is expected to be present (non-null value).

#### Example 1

```java
Feature feature = new Feature();
Optional<Feature> optionalFeature = Optional.of(feature); 
System.out.println(Optional.of(optionalFeature).isPresent());
// Output: true
```

#### Example 2

A blank string can represent a present (non-null) value.
```java
String firstName = "";
System.out.println(Optional.of(firstName).isPresent());
// Output: true
```

## Replace if (var == null)

Replacing a null-based control block.

```java
Feature feature = application.getFeature();
if (feature != null) {
    System.out.println(feature.getVersion());
}
```

The null check can now be replaced with:

```java
Optional<Feature> feature = application.getFeature();
if (feature.isPresent()) {
    System.out.println(feature.get().getVersion());
}
```

## Reduce if-else logic using functional methods

```java
Feature feature = application.getFeature();
String version = null;
if (feature != null) {
    version = feature.getVersion();   
}
System.out.println(version);
```

```java
String version = application.getFeature().map(Feature::getVersion).orElse("NO VERSION");
System.out.println(version);
```

## Streaming calls

The following call can fail several ways when someone along the call chain a null object is returned.
```java
String featureAttribute = app.getFeature().getAttributes().get("attr1");
```

An typical null-based code would look like this.  You can see below how ugly the code gets and the level of nesting it generates.
```java
String attrValue;
MyApplication app = loader.loadApplication(MyApplication.class);
if (app != null) {
    Feature feature = app.getFeature();
    if (feature != null) {
        Map<String,String> attributes = feature.getAttributes();
        if (attributes != null) {
            attrValue = attributes.get("attr1");
        }
    }   
}
```


The null-based code block can be replaced with the following streaming call using *flatMap*:
```java
Optional<MyApplication> app = loader.loadApplication(MyApplication.class);
String attrValue = app.flatMap(MyApplication::getFeature)
                      .flatMap(MyApplication.Feature::getAttributes)
                      .map(m -> m.get("attr1"))
                      .orElse("");
```
The following code looks a lot cleaner and (big AND) there's no literal null checks.

## Conclusion

The Optional-based programming would be best for you to protect your code against null pointers exceptions.  The goal of java.lang.Optional will not replace all null reference in your code but rather help create a better and cleaner code. 
