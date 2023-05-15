---
title: "Java • Converting Strings To Map"
title_style: title2
canonical_url: https://www.kapresoft.com/java/2023/05/03/java-string-to-map.html
category: java
related: java
image: /assets/images/kapresoft1-210x.png
description: "Convert key-value pairs to a Java Map with loops or Stream API. Streamline code for efficient processing and optimize for performance"
---

## Overview

This article discusses converting a string of key-value pairs that are delimited by a specific character, known as a delimiter, into a Map in Java.<!--excerpt--> The key-value pairs are in the format "key=value", and are separated by the delimiter character. 

For instance, a common delimiter used in such situations is the semi-colon character. To perform this conversion, we can split the input string into an array of key-value pairs using the delimiter, then split each key-value pair into an array of key and value using another delimiter, such as the equals sign. 

We can then create a Map from the key-value pairs, using the put() method to add each pair to the Map. Alternatively, we can use the _Stream API_ to write a functional version of the code that performs the same conversion. We can also filter out specific key-value pairs based on certain conditions, such as filtering out a pair that has a specific value.

**Example Code 1:** Traditional Iteration

```java
String input = "1=John;2=Jane;3=Bob";
Map<String, String> map = new HashMap<>();

String[] pairs = input.split(";");
for (String pair : pairs) {
    String[] keyValue = pair.split("=");
    if (keyValue.length == 2) {
        String key = keyValue[0];
        String value = keyValue[1];
        map.put(key, value);
    }
}

System.out.println(map); // Output: {1=John, 2=Jane, 3=Bob}
```

In this example, we first split the input string into key-value pairs using the semi-colon delimiter. Then, we loop through each pair, split it into key and value using the equals sign delimiter, and put it into the Map using the _put()_ method. Finally, we print the Map to verify the result.

## Can we improve the previous example with functional programming in Java?

Example can be further improved by using the _Stream_ API to write a functional version of the code that converts a string with key-value pairs delimited by semi-colons into a _Map_ in Java.

Here's an example code snippet that demonstrates how you can use the _Stream_ API to accomplish this:

```java
String input = "1=John;2=Jane;3=Bob";

Map<String, String> map = Arrays.stream(input.split(";"))
    .map(pair -> pair.split("="))
    .filter(keyValue -> keyValue.length == 2)
    .collect(Collectors.toMap(keyValue -> keyValue[0], keyValue -> keyValue[1]));

System.out.println(map); // Output: {1=John, 2=Jane, 3=Bob}
```

In this example, we first split the input string into an array of key-value pairs using the semi-colon delimiter. Then, we use the _map()_ method to split each pair into an array of key and value using the equals sign delimiter. We filter out any pairs that don't have exactly two elements using the _filter()_ method.

Finally, we use the _Collectors.toMap()_ method to collect the filtered key-value pairs into a _Map_, using the first element of each array as the key and the second element as the value.

This functional version has the benefit of being more concise and expressive than the imperative version.

## If I want to exclude or remove specific data, what should I do?

If you want to filter out the key-value pair with the value "Bob" for example, you can add an additional filter operation to the _Stream_ pipeline. Here's an example code snippet that demonstrates this:

**Code Example 2:**  Using Streams

```java
String input = "1=John;2=Jane;3=Bob";

Map<String, String> map = Arrays.stream(input.split(";"))
    .map(pair -> pair.split("="))
    .filter(keyValue -> keyValue.length == 2)
    .filter(keyValue -> !"Bob".equals(keyValue[1])) // filter out "Bob"
    .collect(Collectors.toMap(keyValue -> keyValue[0], keyValue -> keyValue[1]));

System.out.println(map); // Output: {1=John, 2=Jane}
```

In this example, we added an additional _filter()_ operation to the _Stream_ pipeline that checks if the second element of the key-value pair is not equal to "Bob". This will exclude the key-value pair with the value "Bob" from the resulting _Map_. The output shows that the resulting _Map_ only contains the key-value pairs for "John" and "Jane".

## Why Streams?

a _Stream_ is a sequence of elements that can be processed in parallel or sequentially. The _Stream API_ provides functional programming operations such as map, filter, and reduce, which allow you to process the elements of a stream in a more concise and expressive way than traditional loops.

In terms of performance, the main difference between Example 1 and Example 2 is that Example 2 uses the _Stream API_, which can potentially offer better performance for large datasets. When using the _Stream API_, the processing of elements can be split into multiple threads, which can lead to faster execution times on multi-core processors. This is especially true for large datasets where the processing of each element takes a significant amount of time.

On the other hand, Example 1 uses a traditional loop to iterate over the elements of the input string. This approach is simple and straightforward, but it may not be as efficient as using the _Stream API_ for large datasets.

It's worth noting, however, that the performance benefits of using Streams may not always be significant, and that it depends on the specific use case and the size of the data being processed. Therefore, it's important to benchmark and test different implementations to determine the most efficient solution for a given problem.

## In Conclusion

In conclusion, working with key-value pairs that are delimited by a specific character can be a common task in Java programming. By using the _Map_ data structure and the _Stream API_, you can easily and efficiently convert a string of key-value pairs into a _Map_. 

The traditional approach using loops is simple and straightforward, but the _Stream API_ can offer better performance for large datasets and can result in more concise and expressive code. Additionally, the _Stream API_ provides functional programming operations that allow you to filter, transform and reduce the elements of a stream in a more elegant and readable way. 

Overall, whether you choose to use traditional loops or the _Stream API_, understanding both approaches will enable you to write cleaner and more efficient code when working with key-value pairs in Java.
