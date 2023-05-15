---
title: "Getting Started with Maven Build System in Java Projects"
title_style: titlew
canonical_url: https://www.kapresoft.com/java/2018/08/16/getting-started-with-maven.html
category: java
related: java
redirect_from: 
    - /p/getting-started-with-maven.html
    - /getting-started-with-maven.html
image: /assets/images/kapresoft1-210x.png
description: "Learn how to use Maven for the first time with this comprehensive guide. Get started with the Maven build system and improve your Java project."
---

## Overview

The following page will illustrate how to get started with the maven build system in your
java projects.&nbsp;&nbsp;Use this guide as a reference when using Maven for the very first time.

<!--excerpt-->

## Table of Contents

1. Prerequisite
2. What is Maven?
3. Downloading and Installing Maven
4. Environment Variables and System Paths
5. Your First Maven Project

{% include separator.html %}

## 1.&nbsp;&nbsp;Prerequisite
- JDK 1.10 or below installed ~ [Getting Started with Java](/getting-started-with-java.html)

## 2.&nbsp;&nbsp;What is Maven?

Maven is a project management utility that provides a means to manage builds, dependencies,
documentation, reporting, source control management, releases and distribution.

- <a target="_blank" href="https://maven.apache.org/index.html">Maven Project</a>

<!-- ##################################################### -->


## 3.&nbsp;&nbsp;Downloading and Installing Maven

### Mac OS&trade; and other Unix or Linux Systems

Download Maven and install where you usually put your java tools.&nbsp;&nbsp;A common
place to put them in a Unix/Linux system is /usr/local/.&nbsp;&nbsp;For the purpose of
this document, the maven install path will be /usr/local/apache-maven.

### Windows&trade;

In Windows, use a common place to install your java tools like C:\java.&nbsp;&nbsp;For the
purpose of this document, the maven install path will be C:\java\apache-maven.

<!-- ##################################################### -->


## 4.&nbsp;&nbsp;Environment Variables and System Paths

### Mac OS&trade; and other Unix or Linux Systems

```bash
M2_HOME=/usr/local/apache-maven
```

### Windows&trade;

```bash
M2_HOME=C:\java\apache-maven
```

Specifying a path will allow you to directly use the maven command "mvn" without having
to specify the full path.&nbsp;&nbsp;This is a convenient way to execute a command.

When maven is not in the system path, the command to execute maven looks like this:

```bash
$ /usr/local/apache-maven/bin/mvn --version
```

When Maven is in the system path, maven can be executed from anywhere without specifying the entire path.

```bash
$ mvn --version
Output:
 Java HotSpot(TM) 64-Bit Server VM warning: ignoring option MaxPermSize=128m; support was removed in 8.0
 Apache Maven 3.3.3 (7994120775791599e205a5524ec3e0dfe41d4a06; 2015-04-22T04:57:37-07:00)
 Maven home: /usr/local/apache-maven
 Java version: 1.8.0_161, vendor: Oracle Corporation
 Java home: /Library/Java/JavaVirtualMachines/jdk1.8.0_161.jdk/Contents/Home/jre
 Default locale: en_US, platform encoding: UTF-8
 OS name: "mac os x", version: "10.13.6", arch: "x86_64", family: "mac"
```

### Mac OS&trade;

Add the following export line in your $HOME/.bashrc file

```bash
export M2_HOME=/usr/local/apache-maven
```

Add the following entry to your /etc/paths file as shown on line #7.

```bash
$ cat /etc/paths
Output:
 /usr/local/bin
 /usr/bin
 /bin
 /usr/sbin
 /sbin
 /usr/local/apache-maven/bin
```

### Other Unix and Linux Systems

Line #1 will define the environment variable M2_HOME.  Line #2 will add maven to the system
path.

```bash
export M2_HOME=/usr/local/apache-maven
export PATH=$PATH:$M2_HOME/bin
```

Verify in Mac and other Unix/Linux Systems that maven is in the system path by executing
this command in the terminal.

```bash
$ mvn --version
Output:
 Java HotSpot(TM) 64-Bit Server VM warning: ignoring option MaxPermSize=128m; support was removed in 8.0
 Apache Maven 3.3.3 (7994120775791599e205a5524ec3e0dfe41d4a06; 2015-04-22T04:57:37-07:00)
 Maven home: /usr/local/apache-maven
 Java version: 1.8.0_131, vendor: Oracle Corporation
 Java home: /Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home/jre
 Default locale: en_US, platform encoding: UTF-8
 OS name: "mac os x", version: "10.12.5", arch: "x86_64", family: "mac"
```

### Windows&trade;

Setup the environment variable in a windows system by following the series of steps below.

- Right-click on the My Computer or This PC. and select the **Properties** from the menu item. The Control Panel window will open up.
- From the Control Panel Window select the **Advanced system settings**. The **System Properties** dialog will appear.
- From the **System Properties** dialog click the **Environment Variables** button. The Environment Variables window will appear.
- From the **Environment Variables** window, add M2_HOME as a variable and the value should be the path of your java home diretory, i.e. C:\java\apache-maven

The second part of a JDK Windows installation is to add the Maven to the system path.

From the **Environment Variables** window in the previous step, search for the **path** variable in the **System Variables** section and click the Edit button.
Add %M2_HOME%\bin to the beginning of the semi-colon (;) separated list of paths. In Windows 10, just add a new path entry instead with the value %M2_HOME%\bin.

Verify maven is in the system path by executing the following in the DOS command console.

```bash
C:\> mvn --version
```

<!-- ##################################################### -->

## 5.&nbsp;&nbsp;Your First Maven Project

Creating your first maven project can be done in several ways.  One convenient way is to use the Maven's archetype mechanism.

```bash
$ mvn -B archetype:generate \
  -DarchetypeGroupId=org.apache.maven.archetypes \
  -DgroupId=com.kapresoft \
  -DartifactId=my-first-app
```

Please note that the backslash (\) character is a special character for *nix systems.
The above can be written in one single line as shown here.

```bash
$ mvn -B archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DgroupId=com.kapresoft -DartifactId=my-first-app
```

**Output:**

```bash
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building Maven Stub Project (No POM) 1
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] >>> maven-archetype-plugin:2.3:generate (default-cli) > generate-sources @ standalone-pom >>>
[INFO]
[INFO] <<< maven-archetype-plugin:2.3:generate (default-cli) < generate-sources @ standalone-pom <<<
[INFO]
[INFO] --- maven-archetype-plugin:2.3:generate (default-cli) @ standalone-pom ---
[INFO] Generating project in Batch mode
[INFO] No archetype defined. Using maven-archetype-quickstart (org.apache.maven.archetypes:maven-archetype-quickstart:1.0)
[INFO] ----------------------------------------------------------------------------
[INFO] Using following parameters for creating project from Old (1.x) Archetype: maven-archetype-quickstart:1.0
[INFO] ----------------------------------------------------------------------------
[INFO] Parameter: basedir, Value: /Users/kapresoft
[INFO] Parameter: package, Value: com.kapresoft.com
[INFO] Parameter: groupId, Value: com.kapresoft.com
[INFO] Parameter: artifactId, Value: my-first-app
[INFO] Parameter: packageName, Value: com.kapresoft.com
[INFO] Parameter: version, Value: 1.0-SNAPSHOT
[INFO] project created from Old (1.x) Archetype in dir: /Users/kapresoft/my-first-app
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 3.311 s
[INFO] Finished at: 2017-07-16T09:35:19-07:00
[INFO] Final Memory: 13M/198M
[INFO] ------------------------------------------------------------------------
```

Inspect the directory contents and you will see get familiarize with the project structure
depicted on Figure 4.&nbsp;&nbsp;The pom.xml (1), App.java (2), and the AppTest.java (3)
were created the generating this archetype.

**Figure 4.**&nbsp;&nbsp;Maven project structure

<img alt="Maven Project Structure" src="https://cdngh.kapresoft.com/img/mvn-project-structure-4874190.svg" title="Maven Project Structure" width="553" height="200"/>

Alternatively, you can use the *nix tree command using the terminal to display the following directory tree content.

```bash
$ tree my-first-app
Output:
 ├── pom.xml
 ├── src
 │   ├── main
 │   │   └── java
 │   │       └── com
 │   │           └── kapresoft
 │   │               └── App.java
 │   └── test
 │       └── java
 │           └── com
 │               └── kapresoft
 │                   └── AppTest.java
```

### Project Components

#### The POM XML File (pom.xml)

The pom.xml is the **Project Object Model** file.&nbsp;&nbsp;This is an XML configuration file that contains all 
necessary information about a project.

Since Maven is by convention, a jar project should be able to compile a java class that utilizes the standard JDK 
library.&nbsp;&nbsp;In this example the **AppTest** class is a class used for unit testing and relies on the junit 
library.&nbsp;&nbsp;Library dependencies are declared under the dependencies element of the pom file.


```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">

    <modelVersion>4.0.0</modelVersion>
    <groupId>com.kapresoft.com</groupId>
    <artifactId>my-first-app</artifactId>
    <packaging>jar</packaging>
    <version>1.0-SNAPSHOT</version>
    <name>my-first-app</name>
    <url>http://maven.apache.org</url>

    <dependencies>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>3.8.1</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

</project>
```

#### App.java

The **App** class is your java class containing code to print out "Hello World!".

```java
package com.kapresoft.com;

/**
 * Hello world!
 *
 */
public class App
{
    public static void main( String[] args )
    {
        System.out.println( "Hello World!" );
    }
}
```

#### AppTest.java

The **AppTest** class is a class used for unit testing the **App** class.&nbsp;&nbsp;In this simple example the 
AppTest class is using a simple assertion.&nbsp;&nbsp;In a real world test, the test class will be making 
assertions against the App class to satisfy a usecase.

```java
package com.kapresoft.com;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Unit test for simple App.
 */
public class AppTest extends TestCase
{
    /**
     * Create the test case
     *
     * @param testName name of the test case
     */
    public AppTest( String testName )
    {
        super( testName );
    }

    /**
     * @return the suite of tests being tested
     */
    public static Test suite()
    {
        return new TestSuite( AppTest.class );
    }

    /**
     * Rigourous Test :-)
     */
    public void testApp()
    {
        assertTrue( true );
    }
}
```

### Building your Maven Project

#### Run the compile command

Change to the project directory **my-first-app** and run the maven compile command.&nbsp;&nbsp;This will compile the 
**App** and the **AppTest** classes.

```bash
my-first-app$ mvn compile
Output:
 Java HotSpot(TM) 64-Bit Server VM warning: ignoring option MaxPermSize=128m; support was removed in 8.0
 [INFO] Scanning for projects...
 [INFO]
 [INFO] ------------------------------------------------------------------------
 [INFO] Building my-first-app 1.0-SNAPSHOT
 [INFO] ------------------------------------------------------------------------
 [INFO]
 [INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ my-first-app ---
 [WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
 [INFO] skip non existing resourceDirectory /Users/kapresoft/my-first-app/src/main/resources
 [INFO]
 [INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ my-first-app ---
 [INFO] Changes detected - recompiling the module!
 [WARNING] File encoding has not been set, using platform encoding UTF-8, i.e. build is platform dependent!
 [INFO] Compiling 1 source file to /Users/kapresoft/my-first-app/target/classes
 [INFO] ------------------------------------------------------------------------
 [INFO] BUILD SUCCESS
 [INFO] ------------------------------------------------------------------------
 [INFO] Total time: 1.961 s
 [INFO] Finished at: 2016-07-16T18:48:19-07:00
 [INFO] Final Memory: 13M/245M
 [INFO] ------------------------------------------------------------------------
```

#### Run the compile command with clean option

Optionally, you may instruct maven to scrub clean the project build files which is by default named the **target** 
directory.

```bash
my-first-app$ mvn clean compile
```

#### Packaging your Maven Project

Run the following maven command when packaging the jar file.

```bash
my-first-app$ mvn package
```

### Run the App

You may run the app by setting the classpath parameter "-cp" to the compiled classes folder.

```bash
my-first-app$ java -cp target/classes com.kapresoft.App
Output:
 Hello World!
```

Alternatively, after running the maven package command, you may run the app by setting the classpath to the packaged 
jar file in the target folder.

```bash
my-first-app$ java -cp target/my-first-app-1.0-SNAPSHOT.jar com.kapresoft.App
Output:
 Hello World!
```

