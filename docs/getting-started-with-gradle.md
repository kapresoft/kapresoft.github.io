---
title: Getting Started With Gradle
layout: my-default
---

# Overview

The following page will be an excellent guide with getting started with the gradle build system in your
Java&trade; projects.&nbsp;&nbsp;Use this guide as a reference when using Gradle as a build system for the very first time.

# Table of Contents

1. What is Gradle?
2. Downloading and Installing Gradle
3. Environment Variables and System Paths
4. Your First Gradle Project   
   - Create Project Directory   
   - Create a Gradle Wrapper
   - Initialize a New Gradle Build
   - Initialize Your Project
   - Build Your Project
   - Run Your App
   - Gradle Tasks
5. Gradle Help

<ins class="adsbygoogle"
     style="display:block; text-align:center;"
     data-ad-layout="in-article"
     data-ad-format="fluid"
     data-ad-client="ca-pub-5036910301295841"
     data-ad-slot="9747456101"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>

<hr/>

# 1.&nbsp;&nbsp;What is Gradle?

Gradle is an evolutionary build system that extends upon the concepts of the <b>Apache Ant</b> and the <b>Apache Maven</b> 
build system.&nbsp;&nbsp;The project configuration is based off the <b>Groovy</b> DSL (Domain-specific Language) as 
opposed to the XML form used by Apache Maven.


# 2.&nbsp;&nbsp;Downloading and Installing Gradle

Gradle runs on all major operating systems and requires a Java JDK version 7 or higher to run.&nbsp;&nbsp;In order for 
gradle to run, the <b>JAVA_HOME</b> environment variable must be set.

For the details on installing the <b>Java Development Kit (JDK)</b> please refer to this document:

* [Getting Started With Java](http://www.kapresoft.com/p/get-started-with-java.html)

An example of how to check JAVA_HOME environment variable in a Mac OS:

```bash
$ echo $JAVA_HOME
/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home
```

Check and make sure Java is installed and in the system path:

```bash
$ java -version
java version "1.8.0_131"
Java(TM) SE Runtime Environment (build 1.8.0_131-b11)
Java HotSpot(TM) 64-Bit Server VM (build 25.131-b11, mixed mode)
```

There are several ways to install gradle.&nbsp;&nbsp;This document will cover the basic installation of a downloaded 
zip from the [Gradle Releases](https://gradle.org/releases/) page.

A common place to install software tools in *nix is in the /usr/local folder.&nbsp;&nbsp;For the purpose of this 
document, the gradle install path will be /usr/local/gradle.  In windows, it would be in C:\java.

## Alternative Ways to Install Gradle

There are package managers or installers that will provide an easier way to install gradle.&nbsp;&nbsp;If you are 
familiar with such package managers or installers, here are several examples on alternative ways to install java tools 
software like gradle.&nbsp;&nbsp;Please note that the installation will also automatically add gradle to your system 
path.&nbsp;&nbsp;You may still need to do the manual steps to create the **GRADLE_HOME** environment variable.

Using [Homebrew](http://brew.sh)

```bash
$ brew update && brew install gradle
```

Using [Scoop](http://scoop.sh)

```bash
$ scoop install gradle
```

Using [SDKMAN!](http://sdkman.io)

```bash
$ sdk install gradle 3.5.1
```

<!-- ##################################################### -->

# 3.&nbsp;&nbsp;Environment Variables and System Paths

## Environment Variable for *NIX Systems

In this example, the following environment variable is set for *nix systems:

```
GRADLE_HOME=/usr/local/gradle
```
## Environment Variable for Windows&trade;

For Windows, the following environment variable is set:

```commandline
GRADLE_HOME=C:\java\gradle
```

Adding gradle to the system path will allow you to directly use gradle without having
to specify the full path.&nbsp;&nbsp;This is a convenient way to execute a command.

When gradle is not in the system path, the command to execute will be as follows:

```commandline
$ /usr/local/gradle/bin/gradle --version
```

When gradle is in the system path, it may be executed without specifying the entire path:

```commandline
$ gradle --version
```

## Mac OS&trade;

Add the following export line in your $HOME/.bashrc file

```commandline
export GRADLE_HOME=/usr/local/apache-maven
```

Add the following entry to your /etc/paths file as shown on line #7.

```commandline
$ cat /etc/paths
/usr/local/bin
/usr/bin
/bin
/usr/sbin
/sbin
/usr/local/gradle/bin
```

## Other Unix and Linux Systems

Line #1 will define the environment variable GRADLE_HOME.&nbsp;&nbsp;Line #2 will add gradle to the system path.

```commandline
export GRADLE_HOME=/usr/local/apache-maven
export PATH=$PATH:$GRADLE_HOME/bin</pre>
```

Verify in *nix operating systems that gradle is in the system path by executing this command in the terminal.

```commandline
$ gradle --version
------------------------------------------------------------
Gradle 3.5
------------------------------------------------------------

Build time:   2017-04-10 13:37:25 UTC
Revision:     b762622a185d59ce0cfc9cbc6ab5dd22469e18a6

Groovy:       2.4.10
Ant:          Apache Ant(TM) version 1.9.6 compiled on June 29 2015
JVM:          1.8.0_131 (Oracle Corporation 25.131-b11)
OS:           Mac OS X 10.12.5 x86_64</pre>
```

## Windows&trade;

Setup the environment variable in a Windows operating system by following the series of steps below.

* Right-click on the My Computer or This PC. and select the <b>Properties</b> from the menu item. The Control Panel window will open up.
* From the Control Panel Window select the <b>Advanced system settings</b>. The <b>System Properties</b> dialog will appear.
* From the <b>System Properties</b> dialog click the <b>Environment Variables</b> button. The Environment Variables window will appear.
* From the <b>Environment Variables</b> window, add GRADLE_HOME as a variable and the value should be the path of your java home diretory, i.e. C:\java\gradle

The second part of a JDK Windows installation is to add gradle to the system path.

* From the <b>Environment Variables</b> window in the previous step, search for the <b>path</b> variable in the <b>System Variables</b> section and click the Edit button.
* Add <b>%GRADLE_HOME%</b>\bin to the beginning of the semi-colon (;) separated list of paths. In Windows 10, just add a new path entry instead with the value %GRADLE_HOME%\bin.

Verify gradle is in the system path by executing the following in the DOS command console.

```commandline
C:\> gradle --version
```

<!-- ##################################################### -->

# 4.&nbsp;&nbsp;Your First Gradle Project

### Create Project Directory

Execute the following commands to create the project directory:
```commandline
$ mkdir my-first-app
$ cd my-first-app</pre>
```


### Create a Gradle Wrapper

Execute the following command to initialize gradle wrapper:

```commandline
my-first-app$ gradle wrapper
:wrapper

BUILD SUCCESSFUL

Total time: 1.726 secs
```

Here are the files generated by the wrapper task.

```commandline
my-first-app$ tree
.
├── gradle
│   └── wrapper                                  
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradlew
└── gradlew.bat

2 directories, 4 files
```

#### Created Files

* gradlew - this is the gradlew executable and from now on should be used to run gradle build tasks
* gradlew.bat - this is the DOS equivalent of gradlew.
* gradle/wrapper/gradle-wrapper.properties - the gradle wrapper config file

#### The gradle-wrapper.properties file

```commandline
my-first-app$ cat gradle/wrapper/gradle-wrapper.properties
#Sat Jun 23 19:16:07 PDT 2016
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-3.5-bin.zip
```

### Initialize a New Gradle Build

Run the gradlew *init* command:

```commandline
my-first-app$ ./gradlew init
:wrapper UP-TO-DATE
:init

BUILD SUCCESSFUL

Total time: 2.377 secs</pre>
```

The **build.gradle** and **settings.gradle** files were generated by the init task as show on line #3 and #10 respectively.

```commandline
my-first-app$ tree
.
├── build.gradle
├── gradle
│   └── wrapper
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradlew
├── gradlew.bat
└── settings.gradle
```

#### The build.gradle file

The contents of build.gradle file will contain a template with the java plugin block commented.&nbsp;&nbsp;You may enable 
this block by deleting the start and end of the block comment on lines #9 and #31 of the generated code shown 
on *Code Snippet 4.0*.

**Code Snippet 4.0.**&nbsp;&nbsp;The generated build.gradle file

<script src="https://gist.github.com/kapresoft/a000efefd028afa27fb2a4f525a61eab.js"></script>

The following code snippet shows the uncommented block to enable the java plugin support.

**Code Snippet 4.1.**&nbsp;&nbsp;The build.gradlew file with the block comments removed.
```groovy
/*
 * This build file was generated by the Gradle 'init' task.
 *
 * This generated file contains a commented-out sample Java project to get you started.
 * For more details take a look at the Java Quickstart chapter in the Gradle
 * user guide available at https://docs.gradle.org/3.5/userguide/tutorial_java_projects.html
 */


// Apply the java plugin to add support for Java
apply plugin: 'java'

// In this section you declare where to find the dependencies of your project
repositories {
    // Use 'jcenter' for resolving your dependencies.
    // You can declare any Maven/Ivy/file repository here.
    jcenter()
}

// In this section you declare the dependencies for your production and test code
dependencies {
    // The production code uses the SLF4J logging API at compile time
    compile 'org.slf4j:slf4j-api:1.7.22'

    // Declare the dependency for your favourite test framework you want to use in your tests.
    // TestNG is also supported by the Gradle Test task. Just change the
    // testCompile dependency to testCompile 'org.testng:testng:6.8.1' and add
    // 'test.useTestNG()' to your build script.
    testCompile 'junit:junit:4.12'
}
```


### Initialize Your Project

#### Project Layout

The default project layout that the java plugin implicitly uses is shown below.

**Table 1.0.**&nbsp;&nbsp;The default project layout

| Directory | Description |
| :-------- | :---------- |
| src/main/java | The production Java code |
| src/main/resources | The production resources file |
| src/test/java | The test java code |
| src/test/resources | The test java resources file |

#### Create the source directories:

```commandline
$ mkdir -p src/main/java src/test/java
```

For the purpose of this demonstration create a simple App.java and AppTest.java in the package com.kapresoft.&nbsp;&nbsp;
The src directory should contain the following files.

```commandline
my-first-app$ tree ./src
./src
├── main
│   └── java
│       └── com
│           └── kapresoft
│               └── App.java
└── test
    └── java
        └── com
            └── kapresoft
                └── AppTest.java

8 directories, 2 files
```

#### App.java

```java
package com.kapresoft;

/**
 * Hello world!
 *
 */
public class App
{
    public String getAppId() {
        return "hello-world";
    }

    public static void main( String[] args )
    {
        System.out.println( "Hello World!" );
    }
}
```


#### AppTest.java

```java
package com.kapresoft;

import junit.framework.TestCase;

/**
 * Unit test for simple App.
 */
public class AppTest extends TestCase {

    public void testAppId() {
        App app = new App();
        assertEquals("App ID", "hello-world", app.getAppId());
    }

}
```

### Build Your Project

Now that we have created the **App.java** and **AppTest.java** we are ready to build the project.

This can be done by executing the <b>build</b> task as show below.

```commandline
my-first-app$ ./gradlew build
:compileJava
:processResources NO-SOURCE
:classes
:jar
:assemble
:compileTestJava
:processTestResources NO-SOURCE
:testClasses
:test
:check
:build

BUILD SUCCESSFUL

Total time: 7.544 se
```

### Run Your App

Run your App using the built jar library

````commandline
my-first-app$ java -cp build/libs/my-first-app.jar com.kapresoft.App
Hello World!
````

Or you may run using the built classes folder

```commandline
my-first-app$ java -cp build/classes/main com.kapresoft.App
Hello World!
```

### Gradle Tasks

Gradle provides many available automated tasks. For the purpose of this documentation we are only interested in 
the **build** task.  Please refer to the Gradle documentation for full details.

The following command will display all available tasks for the project.

```commandline
my-first-app$ gradlew tasks --all
:tasks

------------------------------------------------------------
All tasks runnable from root project
------------------------------------------------------------

Build tasks
-----------
assemble - Assembles the outputs of this project.
build - Assembles and tests this project.
buildDependents - Assembles and tests this project and all projects that depend on it.
buildNeeded - Assembles and tests this project and all projects it depends on.
classes - Assembles main classes.
clean - Deletes the build directory.
jar - Assembles a jar archive containing the main classes.
testClasses - Assembles test classes.

Build Setup tasks
-----------------
init - Initializes a new Gradle build.
wrapper - Generates Gradle wrapper files.

Documentation tasks
-------------------
javadoc - Generates Javadoc API documentation for the main source code.

Help tasks
----------
buildEnvironment - Displays all buildscript dependencies declared in root project 'my-first-app'.
components - Displays the components produced by root project 'my-first-app'. [incubating]
dependencies - Displays all dependencies declared in root project 'my-first-app'.
dependencyInsight - Displays the insight into a specific dependency in root project 'my-first-app'.
dependentComponents - Displays the dependent components of components in root project 'my-first-app'. [incubating]
help - Displays a help message.
model - Displays the configuration model of root project 'my-first-app'. [incubating]
projects - Displays the sub-projects of root project 'my-first-app'.
properties - Displays the properties of root project 'my-first-app'.
tasks - Displays the tasks runnable from root project 'my-first-app'.

Verification tasks
------------------
check - Runs all checks.
test - Runs the unit tests.

Other tasks
-----------
compileJava - Compiles main Java source.
compileTestJava - Compiles test Java source.
processResources - Processes main resources.
processTestResources - Processes test resources.

Rules
-----
Pattern: clean&lt;TaskName&gt;: Cleans the output files of a task.
Pattern: build&lt;ConfigurationName&gt;: Assembles the artifacts of a configuration.
Pattern: upload&lt;ConfigurationName&gt;: Assembles and uploads the artifacts belonging to a configuration.

BUILD SUCCESSFUL

Total time: 0.961 secs
```

### Gradle Help

If you need more details on a particular task you may use the built-in help.

This command will display help on the <b>build</b> task.

```commandline
my-first-app$ gradlew help --task build
:help
Detailed task information for build

Path
     :build

Type
     Task (org.gradle.api.Task)

Description
     Assembles and tests this project.

Group
     build

BUILD SUCCESSFUL

Total time: 0.923 secs
```

