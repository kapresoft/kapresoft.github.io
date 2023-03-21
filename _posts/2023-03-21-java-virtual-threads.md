---
draft: true
title: Java Virtual Threads
canonical_url: https://www.kapresoft.com/java/2023/03/21/java-virtual-threads.html
category: java
image: /assets/images/kapresoft1-210x.png
description: "Java Virtual Threads (TBD)"
---

[//]: # https://twitter.com/maciejwalkowiak/status/1638099336323121154 ()
[//]: # https://github.com/spring-projects/spring-framework/issues/23443#issuecomment-1477424658 ()
[//]: # https://blogs.oracle.com/javamagazine/post/java-loom-virtual-threads-platform-threads ()
[//]: # JDK 19 ()

## Overview

Java Virtual Threads (TBD)
<!--excerpt-->

### What are Java Virtual Threads?

In Java, virtual threads are lightweight threads that are managed by the Java Virtual Machine (JVM). They are also known as fibers or continuations.

Virtual threads are different from traditional threads, as they do not have their own native operating system thread associated with them. Instead, they are managed by the JVM, which can schedule them more efficiently than traditional threads.

Virtual threads are created using the Thread.startVirtualThread() method, which creates a virtual thread that is scheduled by the JVM. When a virtual thread is created, it is associated with a virtual processor, which is a lightweight representation of a CPU core. The JVM can then schedule virtual threads on virtual processors in a way that maximizes resource utilization and minimizes overhead.

One advantage of virtual threads is that they are very lightweight, so they can be created and destroyed quickly. This makes them useful for tasks that require a large number of short-lived threads, such as I/O-intensive applications.

Another advantage of virtual threads is that they can be used to implement cooperative multitasking. In cooperative multitasking, the threads voluntarily yield the CPU when they are waiting for some operation to complete. This can reduce the overhead of context switching and improve the overall performance of the system.

Virtual threads were introduced in Java 16 as part of Project Loom, which aims to improve the scalability and responsiveness of Java applications.

## In Conclusion

> TBD
