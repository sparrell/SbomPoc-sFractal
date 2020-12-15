# SbomPoc
Webserver with status of SBOM Poc

## Setup guide
First ensure you have the following set up in your computer
- elixir 1.10.4
- nodejs > 12 LTS
- Postgresql > 11

You can use [the phoenix installation guide](https://hexdocs.pm/phoenix/installation.html#content) to ensure you
have everything set up as expected

## Installing SBOM utilities
You will need to install the following dependancies to enable production of SBOM files from the command line

```shell
npm install -g @cyclonedx/bom
```

### Password for accessing the sbom dashboard
```shell
username: sbom
password: sbom
```

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Convenience make tasks
This project includes a couple of convenience `make` tasks. To get the full list
of the tasks run the command `make targets` to see a list of current tasks. For example

```shell
Targets
---------------------------------------------------------------
compile                compile the project
format                 Run formatting tools on the code
lint-compile           check for warnings in functions used in the project
lint-credo             Use credo to ensure formatting styles
lint-format            Check if the project is well formated using elixir formatter
lint                   Check if the project follows set conventions such as formatting
test                   Run the test suite
sbom                   Create SBOM file for hex and npm deps
```

## Generating SBOM file

To generate an sbom file, use the make task `make sbom` to generate a `bom.json` and `bom.xml` file on the project root.

**Before you begin:**
 - [Download cyclonedx-cli tool](https://github.com/CycloneDX/cyclonedx-cli/releases) that supports converting
 of sbom in different formats.
 - Ensure that the `cyclonedx-cli tool` is executable, if not use the command to make it executable `chmod a+x cyclonedx-cli tool`
 - Add the `cyclonedx-cli tool` to the root of the project and rename it to `cyclonedx-cli**

**Note: If you get an error on MacOS**
```shell
cannot be opened because the developer cannot be verified. macOS cannot verify that this app is free from malware
```
You might get an error when running this command on a mac, follow [instructions on stackoverflow](https://stackoverflow.com/a/59899342/4137155) to allow the binary to execute

## BOM analysis tool
If you want to deploy your own bom analysis tool, you can [follow this instructions](./docs/dependancy-tracker.md) to get set up

## Deployment to GCP

Instructions to deployment can be found on [deployment docs](./docs/deployment.md)



## Adding status
You can add your project status as markdown content by adding a markdown file to the `/status` directory.

Your markdown file needs to have an author and the body.

```markdown
%{
  author: "Your company name or your name"
}

---

The body of your content
```

### The author
This is at the top of the file and can look like this:

```markdown
%{
  author: "Your company name or your name"
}
```
### The body

The body comes immediatly after the author declaration and is marked by three dashes `---`

```markdown
---

The body of your content
```

A sample file can be found at [status/sample.md](status/sample.md)
