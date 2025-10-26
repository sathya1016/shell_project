 1  #/bin/bash
     2  #
     3  #
     4  ###############
     5  #Author : Sathya
     6  #Version : V1
     7  #Date : 25-10-2025
     8  #About : github users lists using shell script
     9  #
    10  #
    11  #
    12  #
    13  #


    14  repo="https://api.github.com/"
    15  USERNAME=$username
    16  TOKEN=$token
    17  OWNER=$1
    18  REPO=$2


    19  function github {
    20          local endpoint=${repo}/${OWNER}

    21          curl -s -u ${USERNAME}:${TOKEN} "${endpoint}"


    22  }
    23  function output {
    24          local end=repos/${OWNER}/${REPO}/collaborators
    25          collabrators="$(github "$end" | jq -r '[.[]?] | .[] | select(type == "object" and .permissions.pull == true) | .login')"


    26  if [[ -z "$collaborators" ]]; then
    27          echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    28      else
    29          echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
    30          echo "$collaborators"
    31      fi
    32  }





    33  output