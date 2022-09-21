#!/bin/bash
# The Directory and Identifier variables.
Directory=${1}
Identifier=${2}

# Checks if the parameters provided by the user is equal to 2 arguments.
# If it is not equal to 2 arguments it will prompt the user about the proper formatting and usage.
# Else it will prompt the user to verify if they would want to continue with the creation of the directory structure.
if [[ $# > 2 || $# < 2 ]]; then
    echo "You need to provide two arguments for this script to work. "
    echo "Usage: make-go-dir <root directory name> <identifier name>"
else
    echo "I am about to create a directory structure named *$Directory*."
    echo "Do you want me to continue? [Yes/no]"
fi

# Get the yes or no response from user.
read Response

# Checks if user the user confirms with a Yes.
# If the Response is a Yes then proceed with the directory structure creation.
if [[ "$Response" = "Yes" ]]; then
    echo "Creating directory structure..."
    mkdir $Directory
    cd $Directory
    mkdir bin cmd cmd/api internals migrations remote
    touch cmd/api/main.go go.mod Makefile

    # Write the `hello world` program to the `main.go` file.
    echo -e '// File: cmd/api/main.go \n\npackage main \n\nimport "fmt" \n\nfunc main(){ \nfmt.Println("Hello world!") \n}' >> cmd/api/main.go

    # Add the identifier to the go.mod file.
    echo "module $Directory.$Identifier" >> go.mod

    # Display a message to the user informing them that a main.go file has been created for them to test the project.
    echo "I have created a *main.go* file for you to test the directory structure."
    echo "Type *go run ./cmd/api* at the root directory of your project to test your project."
    echo "Thank you."

# If the user types no then print an abort message.
elif [[ "$Response" = "no" ]]; then
    echo "Abort."
fi
