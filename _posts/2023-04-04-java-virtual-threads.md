---
title: Java 19 Virtual Threads
canonical_url: https://www.kapresoft.com/java/2023/04/04/java-virtual-threads.html
category: java
description: "Java 19 Virtual Threads: lightweight and efficient approach to concurrency in Java for high-performance applications."
---

## Overview

In this article, we will provide an overview of virtual threads in Java and their use in concurrent programming. We will define what virtual threads are and how they differ from normal threads. Additionally, we will discuss the benefits of virtual threads over traditional concurrency approaches and provide code examples to illustrate the differences between the two.<!--excerpt--> By the end of this article, you should have a better understanding of Java Virtual Threads and how they can be used to write more efficient and scalable concurrent code in Java.

## What are Java Virtual Threads?

In Java 19, virtual threads are lightweight threads that are managed by the Java Virtual Machine (JVM). They are also known as fibers or continuations.

Virtual threads are different from traditional threads, as they do not have their own native operating system thread associated with them. Instead, they are managed by the JVM, which can schedule them more efficiently than traditional threads.

Virtual threads are created using the Thread.startVirtualThread() method, which creates a virtual thread that is scheduled by the JVM. When a virtual thread is created, it is associated with a virtual processor, which is a lightweight representation of a CPU core. The JVM can then schedule virtual threads on virtual processors in a way that maximizes resource utilization and minimizes overhead.

One advantage of virtual threads is that they are very lightweight, so they can be created and destroyed quickly. This makes them useful for tasks that require a large number of short-lived threads, such as I/O-intensive applications.

Another advantage of virtual threads is that they can be used to implement cooperative multitasking. In cooperative multitasking, the threads voluntarily yield the CPU when they are waiting for some operation to complete. This can reduce the overhead of context switching and improve the overall performance of the system.

Virtual threads were introduced in Java 16 as part of Project Loom, which aims to improve the scalability and responsiveness of Java applications.

## Normal Thread Example

```java
public class NormalThreadExample {
    public static void main(String[] args) throws InterruptedException {
        Thread thread = new Thread(() -> {
            // Simulate a long-running task
            try {
                Thread.sleep(5000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.println("Thread completed.");
        });

        thread.start();
        System.out.println("Thread started.");

        // Wait for the thread to complete
        thread.join();
        System.out.println("Thread joined.");
    }
}
```

In this example, we create a new _Thread_ object, passing in a lambda expression that represents the task to be executed. The task in this case is to sleep for 5 seconds and then print a message indicating that the thread has completed.

After creating the thread, we start it using the _Thread.start()_ method, and then wait for it to complete using the _Thread.join()_ method. This blocks the main thread until the thread has completed, which means that the main thread is unable to perform any other work while the task is running.

Overall, this example demonstrates how normal threads can be used to execute tasks in parallel, but also highlights some of the limitations of traditional thread-based concurrency, such as the overhead of creating and managing threads, and the potential for blocking and contention.

## Basic Example

Here's a simple example of using Java Virtual Threads to execute a task asynchronously:

```java
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

public class VirtualThreadExample {
    public static void main(String[] args) throws ExecutionException, InterruptedException {
        CompletableFuture<String> future = Thread.startVirtualThread(() -> {
            // Simulate a long-running task
            try {
                Thread.sleep(5000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            return "Hello, world!";
        });

        System.out.println("Waiting for task to complete...");
        String result = future.get();
        System.out.println("Task completed with result: " + result);
    }
}
```

In this example, we create a virtual thread using the _Thread.startVirtualThread()_ method, which takes a lambda expression that represents the task to be executed. In this case, we simulate a long-running task by sleeping for 5 seconds, and then returning a string.

After creating the virtual thread, we use the _CompletableFuture.get()_ method to wait for the task to complete and retrieve its result. Note that because the task is executed asynchronously, the main thread is free to perform other work while the task is running.

Overall, this example demonstrates how Java Virtual Threads can be used to execute tasks asynchronously without blocking the main thread, providing a more efficient and scalable way to handle concurrency in Java applications.

## The Difference in Code

Here's a brief comparison of the minor differences in code between normal threads and virtual threads in Java:

1. Creating a thread:
  - Normal threads are created by creating a new _Thread_ object and passing a _Runnable_ or _Callable_ object to the constructor. Virtual threads are created using the Thread._startVirtualThread()_ method, which takes a _Runnable_ or _Callable_ object as an argument.
1. Starting a thread:
  - Normal threads are started by calling the _Thread.start()_ method on the thread object. Virtual threads are started implicitly when the _startVirtualThread()_ method is called.
1. Waiting for a thread to complete:
  - Normal threads are typically joined using the _Thread.join()_ method, which blocks the calling thread until the target thread has completed. Virtual threads are typically waited on using a _CompletableFuture_, which can be used to asynchronously wait for the thread to complete without blocking the calling thread.

Overall, the syntax for creating and starting threads is very similar between normal and virtual threads, but there are some differences in how threads are managed and synchronized that make virtual threads a more lightweight and efficient option for concurrent programming in Java.

## In Conclusion

Java Virtual Threads provide a powerful new tool for concurrent programming in Java. Virtual threads are implemented on top of native threads but allow developers to write concurrent code in a way that is similar to single-threaded programming. They are managed by the JVM rather than the operating system, which allows for much greater efficiency and scalability. Virtual threads are created using the _Thread.startVirtualThread()_ method and can be used to execute tasks that are either CPU-bound or I/O-bound. Compared to traditional threads, virtual threads offer a more lightweight and efficient way to handle concurrency in Java applications, making them well-suited for applications that need to handle large numbers of concurrent requests with high performance and scalability requirements.
