# karaf4-sti

An image that can be used with Openshift's Source To Image in order to build Karaf4 based maven projects.

## Usage:
	sti build <git repo url> dhirajsb/karaf4-sti <target image name>
	docker run <target image name>

## Configuring the karaf4 assembly

The location of the karaf4 assembly built by the maven project can be provided in multiple ways.

- Inside the pom.xml using the `docker.env.KARAF4_ASSEMBLY` property.
- By using the -e flag in sti command (e.g. sti build -e "KARAF4_ASSEMBLY=my-artifactId-1.0-SNAPSHOT.tar.gz" ....).
- By setting `KARAF4_ASSEMBLY` property in .sti/environment under the projects source.

## Customizing the build

It may be possible that the maven build needs to be customized. For example:

- To invoke custom goals.
- To skip tests.
- To provide custom configuration to the build.
- To build specific modules inside a multimodule project.
- To add debug level logging to the Maven build.

The `MAVEN_ARGS` environment variable can be set to change the behaviour. By
default `MAVEN_ARGS` is set to:

  install karaf:assembly karaf:archive -DskipTests -e -X

The -X at the end uses maven debug mode to extract the value of `docker.env.KARAF4_ASSEMBLY` property.

You can override the `MAVEN_ARGS` like in the example below we tell maven to just build the project with groupId "some.groupId" and artifactId "some.artifactId" and all its module dependencies.

	sti build -e "MAVEN_ARGS=install -pl some.groupId:some.artifactId -am" <git repo url> dhirajsb/karaf4-sti <target image name>

You can also just override the `MAVEN_DEBUG_ARGS` environment variable with:

  -e "MAVEN_DEBUG_ARGS=-X"

## Working with multimodule projects
The example above is pretty handy for multimodule projects. Another useful option is the OUTPUT_DIR environment variable. This variable defines where in the source tree the output will be generated.
By default the image assumes ./target. If its another directory we need to specify the option.

A more complete version of the previous example would then be:

	sti build -e "OUTPUT_DIR=path/to/module/target,MAVEN_ARGS=install -pl some.groupId:some.artifactId -am" <git repo url> dhirajsb/karaf4-sti <target image name>

### Real world examples:

	sti build git://github.com/dhirajsb/camel-hello-world dhirajsb/karaf4-sti dhirajsb/camel-hello-world --loglevel=5
