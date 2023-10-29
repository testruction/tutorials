#!/usr/bin/env bash

function get_username()
{
    user="testruction"
    message="Enter your Github user name or organization (default: \"testruction\"):"
    # this will take password letter by letter
    while IFS= read -p "${message}" -r -s -n 1 letter
    do
        # if you press enter then the condition 
        # is true and it exit the loop
        if [[ $letter == $'\0' ]]
        then
            break
        fi

        # the letter will store in password variable
        user+=$letter

        # in place of password the asterisk (*) 
        # will printed
        message="$letter"
    done
    echo
    # echo "Your password is read with asterisk (*)."

    echo GITHUB_USER=\"${user}\" >> /tmp/.github_env
}

function get_password()
{
    password=""
    message="Enter your Github Personal Access Token (PAT):"
    # this will take password letter by letter
    while IFS= read -p "${message}" -r -s -n 1 letter
    do
        # if you press enter then the condition 
        # is true and it exit the loop
        if [[ $letter == $'\0' ]]
        then
            break
        fi

        # the letter will store in password variable
        password+=$letter

        # in place of password the asterisk (*) 
        # will printed
        message="*"
    done
    echo
    # echo "Your password is read with asterisk (*)."

    echo GITHUB_TOKEN=\"${password}\" >> /tmp/.github_env
}

get_username
get_password