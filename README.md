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
To generate an sbom file, use the make task `make sbom` to generate an `sbom.xml` file on the project root

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
