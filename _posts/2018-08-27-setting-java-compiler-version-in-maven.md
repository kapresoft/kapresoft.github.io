---
title: Setting Java Compiler Version in Maven
canonical_url: https://www.kapresoft.com/java/2018/08/27/setting-java-compiler-version-in-maven.html
image: /assets/images/kapresoft1-210x.png
category: java
description: "Set the java compiler version in maven via the maven.compiler.target property and the maven-compiler-plugin configuration section."
---

# Overview

This document demonstrates ways to set the java compiler version in maven via the **maven.compiler.target** property and the **maven-compiler-plugin** configuration section.

<!--excerpt-->

## Prerequisite
- JDK 1.10 or below installed ~ [Getting Started with Java](/getting-started-with-java.html)
- Maven 3.8.0 and above installed ~ [Getting Started with Maven](/getting-started-with-maven.html)

# Setting the java compiler via maven property

```xml
<properties>
    <java.version>1.10</java.version>
    <maven.compiler.target>${java.version}</maven.compiler.target>
    <maven.compiler.source>${java.version}</maven.compiler.source>
</properties>
```

# Setting the java compiler via the plugin config

- For maven-compiler-version below version 3.8.0 has the default compiler set to 1.5
- Since maven-compiler-version 3.8.0, the default java compiler version is now 1.6
  - See also: <a target="_blank" href="https://maven.apache.org/plugins/maven-compiler-plugin/">maven-compiler-plugin</a> doc.

```xml

<properties>
    <java.version>1.10</java.version>
    <maven-compiler-plugin.version>3.8.0</maven-compiler-plugin.version>
</properties>

<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>${maven-compiler-plugin.version}</version>
            <configuration>
                <source>${java.version}</source>
                <target>${java.version}</target>
            </configuration>
        </plugin>
    </plugins>
</build>
```

# Compiler Error Message

The following is displayed when a compiler mismatch is detected during **compile** phase.  In this example, the java compiler used (1.7) is less than
the required version (1.10).

```commandline
$ java -version

java version "1.7.0_40"
Java(TM) SE Runtime Environment (build 1.7.0_40-b43)
Java HotSpot(TM) 64-Bit Server VM (build 24.0-b56, mixed mode)
```

## Error Message

The error message as shown on Line 25 of the <a target="_blank" href="https://gist.github.com/kapresoft/71d2c6d703fadcfef3b38e8040feddd3#file-java-compiler-mismatch-log-L25">Maven Console Log</a>

```commandline
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-compiler-plugin:3.8.0:compile 
        (default-compile) on project mvn-demo-java-compiler-version: 
        Fatal error compiling: invalid target release: 1.10 -> [Help 1]
```

## Maven Compile Command

```bash
$ mvn clean install
```

### Maven Console Log

- The error message is on <a target="_blank" href="https://gist.github.com/kapresoft/71d2c6d703fadcfef3b38e8040feddd3#file-java-compiler-mismatch-log-L25">Line #25</a>.

<script src="https://gist.github.com/kapresoft/71d2c6d703fadcfef3b38e8040feddd3.js#25"></script>


#  Example Maven Repo

## Github

- <a target="_blank" href="https://github.com/kapresoft/mvn_set_java_compiler_version">https://github.com/kapresoft/mvn_set_java_compiler_version</a>

## Clone the Repo

```bash
$ git clone https://github.com/kapresoft/mvn_set_java_compiler_version.git
```

## Project pom.xml

- <a target="_blank" href="https://github.com/kapresoft/mvn_set_java_compiler_version/blob/master/pom.xml">pom.xml</a> from the repo.

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.kapresoft.demo</groupId>
    <artifactId>mvn-demo-java-compiler-version</artifactId>
    <packaging>jar</packaging>
    <version>1.0-SNAPSHOT</version>
    <name>mvn-demo-java-compiler-version</name>
    <url>http://maven.apache.org</url>

    <properties>
        <java.version>1.10</java.version>

        <!-- Note 1: Set the following maven property for compiler version -->
        <maven.compiler.target>${java.version}</maven.compiler.target>
        <maven.compiler.source>${java.version}</maven.compiler.source>

        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <maven-compiler-plugin.version>3.8.0</maven-compiler-plugin.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>3.8.1</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <!-- Note 2: Alternate way for setting java compiler version via the maven-compiler plugin -->
            <!--<plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>${maven-compiler-plugin.version}</version>
                <configuration>
                    <source>${java.version}</source>
                    <target>${java.version}</target>
                </configuration>
            </plugin>-->
        </plugins>
    </build>

</project>
```