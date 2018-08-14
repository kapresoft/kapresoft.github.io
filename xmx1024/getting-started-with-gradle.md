<meta charset="UTF-8">
<script src="https://dl.dropboxusercontent.com/s/ogwy8ar5g52c19k/preview.js"></script>
<script src='https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js'></script>

<div class="bc">

# Overview

<div class="d1">
The following page will be an excellent guide with getting started with the gradle build system in your
Java&trade; projects.&nbsp;&nbsp;Use this guide as a reference when using Gradle as a build system for the very first time.
</div>

# Table of Contents
<ol>
<li>What is Gradle?</li>
<li>Downloading and Installing Gradle</li>
<li>Environment Variables and System Paths</li>
<li>Your First Gradle Project
<ol type="a">
<li>Create Project Directory</li>
<li>Create a Gradle Wrapper</li>
<li>Initialize a New Gradle Build</li>
<li>Initialize Your Project</li>
<li>Build Your Project</li>
<li>Run Your App</li>
<li>Gradle Tasks</li>
<li>Gradle Help</li>
</ol>
</li>
<li>Where to go from here?</li>
</ol>

<hr style="margin-top: 30px;"/>

<h1>1.&nbsp;&nbsp;What is Gradle?</h1>

<div class="d1">
Gradle is an evolutionary build system that extends upon the concepts of the <b>Apache Ant</b> and the <b>Apache Maven</b> build system.&nbsp;&nbsp; The project configuration is based off the <b>Groovy</b> DSL (Domain-specific Language) as opposed to the XML form used by Apache Maven.
</div>

<!-- ##################################################### -->

<h1>2.&nbsp;&nbsp;Downloading and Installing Gradle</h1>
<div class="d1">
Gradle runs on all major operating systems and requires a Java JDK version 7 or higher to run.&nbsp;&nbsp;In order for gradle to run, the <b>JAVA_HOME</b> environment variable must be set.
</div>

<div class="d1">
For the details on installing the <b>Java Development Kit (JDK)</b> please refer to this document:<br/>
<a href="http://www.kapresoft.com/p/get-started-with-java.html" style="margin-left: 20px;">Getting Started With Java</a>
</div>

<div class="d1">An example of how to check JAVA_HOME environment variable in a Mac OS:</div>

```bash
$ echo $JAVA_HOME
/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home
```

<div class="d1">Check and make sure Java is installed and in the system path:</div>

```bash
$ java -version
java version "1.8.0_131"
Java(TM) SE Runtime Environment (build 1.8.0_131-b11)
Java HotSpot(TM) 64-Bit Server VM (build 25.131-b11, mixed mode)
```

<div class="d1">
<p>There are several ways to install gradle.&nbsp;&nbsp;This document will cover the basic installation of a downloaded zip from the <a href="https://gradle.org/releases/">Gradle Releases</a> page.</p>
<p>A common place to install software tools in *nix is in the /usr/local folder.&nbsp;&nbsp;For the purpose of this document, the gradle install path will be /usr/local/gradle.  In windows, it would be in C:\java.</p>
</div>

<h4>Alternative Ways to Install Gradle</h4>
<div class="d1">
<p>
There are package managers or installers that will provide an easier way to install gradle.&nbsp;&nbsp;If you are familiar with such package managers or installers, here are several examples on alternative ways to install java tools software like gradle.&nbsp;&nbsp;Please note that the installation will also automatically add gradle to your system path.&nbsp;&nbsp;You may still need to do the manual steps to create the <b>GRADLE_HOME</b> environment variable.</p>
</div>

<div class="d1">
Using <a href="http://brew.sh/">Homebrew</a>
<pre class="prettyprint lang-sh nolinenums">$ brew update && brew install gradle</pre>
</div>

<div class="d1">
Using <a href="http://scoop.sh/">Scoop</a>
<pre class="prettyprint lang-sh nolinenums">$ scoop install gradle</pre>
</div>

<div class="d1">
Using <a href="http://sdkman.io/">SDKMAN!</a>
<pre class="prettyprint lang-sh nolinenums">$ sdk install gradle 3.5.1</pre>
</div>

<!-- ##################################################### -->

<h1>3.&nbsp;&nbsp;Environment Variables and System Paths</h1>
<div class="d1">
In this example, the following environment variable is set for *nix systems:
</div>
<pre class="prettyprint lang-sh nolinenums">GRADLE_HOME=/usr/local/gradle</pre>

<h4>Windows&trade;</h4>
<div class="d1">
For Windows, the following environment variable is set:
</div>
<pre class="prettyprint lang-sh oneline">GRADLE_HOME=C:\java\gradle</pre>


<div class="d1">
Adding gradle to the system path will allow you to directly use gradle without having
to specify the full path.&nbsp;&nbsp;This is a convenient way to execute a command.
</div>

<div class="d1">
When gradle is not in the system path, the command to execute will be as follows:
</div>
<pre class="prettyprint lang-sh oneline">$ /usr/local/gradle/bin/gradle --version</pre>

<div class="d1">
When gradle is in the system path, it may be executed without specifying the entire path:
</div>
<pre class="prettyprint lang-sh oneline">$ gradle --version</pre>

<h4>Mac OS&trade;</h4>

<div class="d1">
Add the following export line in your $HOME/.bashrc file
</div>
<pre class="prettyprint lang-sh oneline">export GRADLE_HOME=/usr/local/apache-maven</pre>

<div class="d1">
Add the following entry to your /etc/paths file as shown on line #7.
<pre class="prettyprint lang-java linenums">$ cat /etc/paths
/usr/local/bin
/usr/bin
/bin
/usr/sbin
/sbin
/usr/local/gradle/bin</pre>
</div>

<h4>Other Unix and Linux Systems</h4>

<div class="d1">
Line #1 will define the environment variable GRADLE_HOME.&nbsp;&nbsp;Line #2 will add gradle to the system path.
</div>
<pre class="prettyprint lang-sh linenums">export GRADLE_HOME=/usr/local/apache-maven
export PATH=$PATH:$GRADLE_HOME/bin</pre>

<div class="d1">
Verify in *nix operating systems that gradle is in the system path by executing this command in the terminal.
</div>

<pre class="prettyprint lang-sh nolinenums">$ gradle --version
------------------------------------------------------------
Gradle 3.5
------------------------------------------------------------

Build time:   2017-04-10 13:37:25 UTC
Revision:     b762622a185d59ce0cfc9cbc6ab5dd22469e18a6

Groovy:       2.4.10
Ant:          Apache Ant(TM) version 1.9.6 compiled on June 29 2015
JVM:          1.8.0_131 (Oracle Corporation 25.131-b11)
OS:           Mac OS X 10.12.5 x86_64</pre>


<h4>Windows&trade;</h4>
<div class="d1">Setup the environment variable in a Windows operating system by following the series of steps below.</div>

<ul>
<li>Right-click on the My Computer or This PC. and select the <b>Properties</b> from the menu item. The Control Panel window will open up.</li>
<li>From the Control Panel Window select the <b>Advanced system settings</b>. The <b>System Properties</b> dialog will appear.</li>
<li>From the <b>System Properties</b> dialog click the <b>Environment Variables</b> button. The Environment Variables window will appear.</li>
<li>From the <b>Environment Variables</b> window, add GRADLE_HOME as a variable and the value should be the path of your java home diretory, i.e. C:\java\gradle</li>
</ul>

<div class="d1">The second part of a JDK Windows installation is to add gradle to the system path.</div>

<ul>
<li>From the <b>Environment Variables</b> window in the previous step, search for the <b>path</b> variable in the <b>System Variables</b> section and click the Edit button.</li>
<li>Add <b>%GRADLE_HOME%</b>\bin to the beginning of the semi-colon (;) separated list of paths. In Windows 10, just add a new path entry instead with the value %GRADLE_HOME%\bin.</li>
</ul>

<div class="d1">Verify gradle is in the system path by executing the following in the DOS command console.</div>
<pre class="prettyprint lang-sh oneline">C:\&gt; gradle --version</pre>


<!-- ##################################################### -->

<h1>4.&nbsp;&nbsp;Your First Gradle Project</h1>

<h4>a.&nbsp;&nbsp;Create Project Directory</h4>
<div class="d1">
(todo)

<pre class="prettyprint lang-sh nolinenums">$ mkdir my-first-app
$ cd my-first-app</pre>
</div>

<h4>b.&nbsp;&nbsp;Create a Gradle Wrapper</h4>

<div class="d1">
(todo)

<pre class="prettyprint lang-sh nolinenums">my-first-app$ gradle wrapper
:wrapper

BUILD SUCCESSFUL

Total time: 1.726 secs</pre>
</div>

<div class="d1">
Here are the files generated by the wrapper task.
<pre class="prettyprint lang-sh nolinenums">my-first-app$ tree
.
├── gradle
│   └── wrapper                                  
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradlew
└── gradlew.bat

2 directories, 4 files</pre>

<ul>
<li>gradlew - this is the gradlew executable and from now on should be used to run gradle build tasks</li>
<li>gradlew.bat - this is the DOS equivalent of gradlew.</li>
<li>gradle/wrapper/gradle-wrapper.properties - the gradle wrapper config file</li>
</ul>

<b>gradle-wrapper.properties</b>
<pre class="prettyprint lang-sh nolinenums">my-first-app$ cat gradle/wrapper/gradle-wrapper.properties
#Sat Jun 23 19:16:07 PDT 2016
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-3.5-bin.zip</pre>

</div>

<h4>c.&nbsp;&nbsp;Initialize a New Gradle Build</h4>
<div class="d1">
(todo)

<pre class="prettyprint nolinenums">my-first-app$ ./gradlew init
:wrapper UP-TO-DATE
:init

BUILD SUCCESSFUL

Total time: 2.377 secs</pre>

The <b>build.gradle</b> and <b>settings.gradle</b> files were generated by the init task as show on line #3 and #10 respectively.
<pre class="prettyprint lang-sh linenums">my-first-app$ tree
.
├── build.gradle
├── gradle
│   └── wrapper
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradlew
├── gradlew.bat
└── settings.gradle</pre>
</div>

<h5>build.gradle</h5>

<div class="d1">
The contents of build.gradle file will contain a template with the java plugin block commented.

<pre class="prettyprint linenums">/*
 * This build file was generated by the Gradle 'init' task.
 *
 * This generated file contains a commented-out sample Java project to get you started.
 * For more details take a look at the Java Quickstart chapter in the Gradle
 * user guide available at https://docs.gradle.org/3.5/userguide/tutorial_java_projects.html
 */

/*
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
*/</pre>
</div>

<div class="d1">
You may enable this block by deleting the start and end comment lines #9 and #31.

<pre class="prettyprint linenums">/*
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
 </pre>
</div>

<h4>d.&nbsp;&nbsp;Initialize Your Project</h4>

<h5>Project Layout</h5>
<div class="d1">
The default project layout that the java plugin implicitly uses is shown below.
</div>

<div class="d1">
<div class="figure"><span>Table 1.0</span><span>The default project layout</span></div>
<table class="definition">
<thead>
<tr>
<th>Directory</th>
<th>Description</th>
</tr>

</thead>
<tr>
<td>src/main/java</td>
<td>The production Java code</td>
</tr>
<tr>
<td>src/main/resources</td>
<td>The production resources file</td>
</td>
</tr>
<tr>
<td>src/test/java</td>
<td>The test java code</td>
</td>
</tr>
<tr>
<td>src/test/resources</td>
<td>The test java resources file</td>
</td>
</tr>
</table>
</div>

<b>Create the source directories</b>
<div class="d1">
(todo)
<pre class="prettyprint lang-sh nolinenums">$ mkdir -p src/main/java src/test/java</pre>

For the purpose of this demonstration create a simple App.java and AppTest.java in the package com.kapresoft.  The src directory should contain the following files.

<pre class="prettyprint lang-sh nolinenums">my-first-app$ tree ./src
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

8 directories, 2 files</pre>

</div>

<b>App.java</b>
<div class="d1">
(todo)

<pre class="prettyprint linenums">package com.kapresoft;

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
}</pre>
</div>

<b>AppTest.java</b>
<div class="d1">
(todo)
<pre class="prettyprint linenums">package com.kapresoft;

import junit.framework.TestCase;

/**
 * Unit test for simple App.
 */
public class AppTest extends TestCase {

    public void testAppId() {
        App app = new App();
        assertEquals("App ID", "hello-world", app.getAppId());
    }

}</pre>
</div>

<h4>e.&nbsp;&nbsp;Build Your Project</h4>
<div class="d1">
Now that we have created the <b>App.java</b> and <b>AppTest.java</b> we are ready to build the project.

<p>This can be done by executing the <b>build</b> task as show below.</p>

<pre class="prettyprint lang-sh nolinenums">my-first-app$ ./gradlew build
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

Total time: 7.544 se</pre>
</div>

<h4>f.&nbsp;&nbsp;Run Your App</h4>
<div class="d1">
Run your App using the built jar library
<pre class="prettyprint lang-sh nolinenums">my-first-app$ java -cp build/libs/my-first-app.jar com.kapresoft.App
Hello World!</pre>

Or you may run using the built classes folder

<pre class="prettyprint lang-sh nolinenums">my-first-app$ java -cp build/classes/main com.kapresoft.App
Hello World!</pre>

</div>

<h4>g.&nbsp;&nbsp;Gradle Tasks</h4>
<div class="d1">
<p>Gradle provides many available automated tasks. For the purpose of this documentation we are only interested in the <b>build</b> task.  Please refer to the Gradle documentation for full details.</p>

<p>The following command will display all available tasks for the project.</p>

<pre class="prettyprint linenums small">my-first-app$ gradlew tasks --all
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

Total time: 0.961 secs</pre>

</div>

<h4>i.&nbsp;&nbsp;Gradle Help</h4>

<div class="d1">
<p>If you need more details on a particular task you may use the built-in help.</p>
<p>This command will display help on the <b>build</b> task.</p>

<pre class="prettyprint nolinenums">my-first-app$ gradlew help --task build
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

Total time: 0.924 secs</pre>
</div>

<h4>5.&nbsp;&nbsp;Where to go from here?</h4>
<div class="d1">
(todo)
</div>

</div><!-- end div.bc -->

